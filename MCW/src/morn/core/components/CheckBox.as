/**
 * Version 0.9.4.1.3 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	
	/**多选按钮*/
	public class CheckBox extends Button {
		
		public function CheckBox(skin:String = null, label:String = "") {
			super(skin, label);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			_toggle = true;
			_autoSize = false;
		}
		
		override protected function initialize():void {
			super.initialize();
			_btnLabel.autoSize = "left";
		}
		
		override protected function changeLabelSize():void {
			_btnLabel.x = _bitmap.width + _labelMargin[0];
			_btnLabel.y = (_bitmap.height - _btnLabel.height) * 0.5 + _labelMargin[1];
		}
		
		override public function set dataSource(value:Object):void {
			if (value is Boolean) {
				selected = value;
			} else {
				super.dataSource = value;
			}
		}
	}
}