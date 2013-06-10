package com.system {
    import flash.display.Sprite;
    import flash.utils.getTimer;

    public class FPSCounter extends Sprite{
        private var last:uint = getTimer();
        private var ticks:uint = 0;

        public function FPSCounter(xPos:int=0, yPos:int=0) {
            this.x = xPos;
            this.y = yPos;
        }

        public function tick() {
            ticks++;
            var now:uint = getTimer();
            var delta:uint = now - last;
            if (delta >= 1000) {
                var fps:Number = ticks / delta * 1000;
                tf.text = (~~fps) + ' FPS';
                ticks = 0;
                last = now;
            }
        }
    }
}