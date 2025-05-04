import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isMuted = false;
  bool _showControls = true;
  bool _isLocked = false;
  bool _isError = false;
  bool _showVolumeSlider = false; // New state for volume slider visibility
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _playbackSpeed = 1.0;
  double _volume = 1.0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _duration = _controller.value.duration;
          _isPlaying = true;
          _controller.play();
        });
        _controller.addListener(_videoListener);
      }).catchError((error) {
        setState(() {
          _isError = true;
        });
      });

    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

   
    _toggleControls();
  }

  void _videoListener() {
    if (mounted) {
      setState(() {
        _position = _controller.value.position;
        _duration = _controller.value.duration;
        _isPlaying = _controller.value.isPlaying;
      });
    }
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
      if (_showControls) {
        _animationController.forward();
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted && _showControls && !_isLocked) {
            setState(() {
              _showControls = false;
              _showVolumeSlider = false; 
              _animationController.reverse();
            });
          }
        });
      } else {
        _animationController.reverse();
        _showVolumeSlider = false; 
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    _animationController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  void _skipForward() {
    final newPosition = _position + const Duration(seconds: 10);
    _controller.seekTo(newPosition > _duration ? _duration : newPosition);
  }

  void _skipBackward() {
    final newPosition = _position - const Duration(seconds: 10);
    _controller.seekTo(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  void _showSpeedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Playback Speed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [0.5, 0.75, 1.0, 1.25, 1.5, 2.0].map((speed) {
            return ListTile(
              title: Text('${speed}x'),
              onTap: () {
                setState(() {
                  _playbackSpeed = speed;
                  _controller.setPlaybackSpeed(speed);
                });
                Navigator.pop(context);
              },
              selected: _playbackSpeed == speed,
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isError
          ? const Center(child: Text('Error loading video', style: TextStyle(color: Colors.white)))
          : Stack(
              children: [
                Center(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
                // Double-tap to skip
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onDoubleTap: _skipBackward,
                        onTap: _isLocked ? null : _toggleControls,
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onDoubleTap: _skipForward,
                        onTap: _isLocked ? null : _toggleControls,
                      ),
                    ),
                  ],
                ),
                // Controls overlay
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _showControls ? _fadeAnimation.value : 0.0,
                      child: IgnorePointer(
                        ignoring: !_showControls,
                        child: Stack(
                          children: [
                            // Top bar
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                                  ),
                                ),
                               
                              ),
                            ),
                            
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Progress bar
                                    VideoProgressIndicator(
                                      _controller,
                                      allowScrubbing: true,
                                      colors: const VideoProgressColors(
                                        playedColor: Colors.red,
                                        bufferedColor: Colors.white54,
                                        backgroundColor: Colors.white24,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _formatDuration(_position),
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          _formatDuration(_duration),
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            _volume == 0
                                                ? Icons.volume_off
                                                : Icons.volume_up,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _showVolumeSlider = !_showVolumeSlider;
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: AnimatedOpacity(
                                            opacity: _showVolumeSlider ? 1.0 : 0.0,
                                            duration: const Duration(milliseconds: 200),
                                            child: _showVolumeSlider
                                                ? Slider(
                                                    value: _volume,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _volume = value;
                                                        _controller.setVolume(value);
                                                        _isMuted = value == 0;
                                                      });
                                                    },
                                                    min: 0.0,
                                                    max: 1.0,
                                                    activeColor: Colors.red,
                                                    inactiveColor: Colors.white24,
                                                  )
                                                : const SizedBox(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    // Control buttons
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.replay_10, color: Colors.white),
                                          onPressed: _skipBackward,
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            _isPlaying ? Icons.pause : Icons.play_arrow,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isPlaying
                                                  ? _controller.pause()
                                                  : _controller.play();
                                              _isPlaying = !_isPlaying;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.forward_10, color: Colors.white),
                                          onPressed: _skipForward,
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.speed,
                                            color: Colors.white,
                                          ),
                                          onPressed: _showSpeedDialog,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.fullscreen, color: Colors.white),
                                          onPressed: () {
                                            SystemChrome.setPreferredOrientations([
                                              DeviceOrientation.landscapeLeft,
                                              DeviceOrientation.landscapeRight,
                                            ]);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}