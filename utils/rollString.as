package com.kaka.utils{

   /* 
     * var isRollText:rollString;
     * isRollText = new rollString(RollTextField,{});
    */

	import com.koolou.Event.KEvent;
    import flash.events.Event;
    import flash.events.TimerEvent;
	import flash.text.TextFormat;

    import flash.text.TextField;

    import flash.utils.Timer;

    import com.kaka.utils.randomExpand;

    public class rollString extends TextField {

        private const stringUtils     = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';       // 滚动字符时的掩盖字符
        private const lengthUtils     = stringUtils.length; // 掩盖字符的长度

        private var $object          :TextField;            // 目标对象

        private var $rollCount       :int;                  // 单个字符滚动次数

        private var $rollSpeed       :Number;               // 单个字符滚动速度

        private var workString       :String;               // 字符串副本
        private var overString       :String;               // 完成滚动的字符串
        private var taskString       :String;               // 正在滚动的字符串

        private var workLength       :int;                  // 字符串副本的长度
        private var nowsLength       :int;                  // 当前滚动到的长度
        private var nowsRollCount    :int;                  // 单个字符已经滚动的次数

        private var workTimer        :Timer;                // 滚动字符串的工作计时器

        private var completeEvent    :Event;                // 滚动完成事件
		private var tm				 :TextFormat;
        /*
         * 滚动字符串初始化构造函数
        */
        public function rollString($target:TextField, $state:Object) : void {

            $object          = $target              is TextField    ? $target              : throwError("$colors 参数类型错误或缺少");
			
            $rollCount       = $state.$rollCount    is int          ? $state.$rollCount    : 1;
            $rollSpeed       = $state.$rollSpeed    is Number       ? $state.$rollSpeed    : 25;

            workString       = $object.text;
            overString       = '';
            taskString       = '';

            workLength       = $object.length;
            nowsLength       = -1;
            nowsRollCount    = 0;

            workTimer        = new Timer($rollSpeed, 0);

            completeEvent    = new Event('ROLLSTRING_COMPLETE');

            function throwError(errorText:String) :void{

                throw new Error(errorText);
            }
			//$object.addEventListener(Event.ENTER_FRAME,ef)
            workTimer.start();
            workTimer.addEventListener(TimerEvent.TIMER, rollBegin);
        }
		private function ef(e:Event)
		{
			tm=new TextFormat()
			tm.letterSpacing = 2.5;
			$object.setTextFormat(tm)
			$object.addEventListener(Event.ENTER_FRAME,ef)
		}
        /*
         * 重置滚动字符串
         *
         * workRoll - 判断字符串是否正在滚动之中, 以完成滚动则从新开始工作计时器并添加工作计时器事件
        */

        public function resetRoll() : void {

            var workRoll :Boolean = workTimer.hasEventListener(TimerEvent.TIMER);

            $object.text = workString;

            overString       = '';
            taskString       = '';
            workLength       = $object.length;
            nowsLength       = -1;
            nowsRollCount    = 0;

            if(workRoll == false) {

                workTimer.start();
                workTimer.addEventListener(TimerEvent.TIMER, rollBegin);
            }
        }

        /*
         * 滚动字符串滚动功能
        */
		
        private function rollBegin(e:TimerEvent) : void {

            if(nowsLength < workLength) { // 判断当前滚动长度是否小于字符串副本的长度

                if(nowsRollCount < $rollCount) { // 判断单个字符已经滚动的次数是否达到单个字符滚动次数的要求

                    nowsRollCount ++;
                } else { // 当单个字符已经滚动的次数达到单个字符滚动次数的要求时, 调整变量以便进入下一个字符的滚动

                    nowsLength ++;
                    nowsRollCount = 0;

                    if(nowsLength > -1) {

                        overString += workString.charAt(nowsLength);
                    }
                }

                for(var i:int; i < (workLength - nowsLength); i++) { // 制造滚动字符时的掩盖字符

                    taskString += stringUtils.charAt(randomExpand.toInteger(0, lengthUtils));
					
                }

                $object.text = overString + taskString; // 将滚动结果呈现到目标对象上
				
				
                taskString = '';

                e.updateAfterEvent();
            } else { // 当当前滚动长度等于或大于字符串副本的长度时, 结束字符串滚动并发送 'ROLLSTRING_COMPLETE' 事件

                workTimer.stop();
                workTimer.removeEventListener(TimerEvent.TIMER, rollBegin);
				
                dispatchEvent(completeEvent);
            }
        }
    }
}
