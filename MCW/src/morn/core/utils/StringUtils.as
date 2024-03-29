/**
 * Version 0.9.4.1.3 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.utils {
	
	/**文本工具集*/
	public class StringUtils {
		/**判断文本为非空*/
		public static function isNotEmpty(str:String):Boolean {
			if (str == null || str == "") {
				return false;
			}
			return true;
		}
		
		/**用字符串填充数组，并返回数组副本*/
		public static function fillArray(arr:Array, str:String):Array {
			var temp:Array = ObjectUtils.clone(arr);
			if (isNotEmpty(str)) {
				var a:Array = str.split(",");
				for (var i:int = 0, n:int = Math.min(temp.length, a.length); i < n; i++) {
					var value:String = a[i];
					temp[i] = (value == "true" ? true : (value == "false" ? false : value));
				}
			}
			return temp;
		}
	}
}