/**
 * Version 0.9.4.1.3 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import morn.core.components.View;
	import morn.core.handlers.Handler;
	import morn.core.managers.AssetManager;
	import morn.core.managers.DialogManager;
	import morn.core.managers.LoaderManager;
	import morn.core.managers.LogManager;
	import morn.core.managers.TimerManager;
	import morn.core.managers.TipManager;
	import morn.core.utils.StringUtils;
	
	/**全局引用入口*/
	public class App {
		/**全局stage引用*/
		public static var stage:Stage;
		/**资源管理器*/
		public static var asset:AssetManager = new AssetManager();
		/**加载管理器*/
		public static var loader:LoaderManager = new LoaderManager();
		/**时钟管理器*/
		public static var timer:TimerManager = new TimerManager();
		/**对话框管理器*/
		public static var dialog:DialogManager = new DialogManager();
		/**日志管理器*/
		public static var log:LogManager = new LogManager();
		/**提示管理器*/
		public static var tip:TipManager = new TipManager();
		
		public static function init(main:Sprite):void {
			stage = main.stage;
			stage.frameRate = Config.GAME_FPS;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.stageFocusRect = false;
			stage.tabChildren = false;
			
			//覆盖配置
			var gameVars:Object = stage.loaderInfo.parameters;
			if (gameVars != null) {
				for (var s:String in gameVars) {
					if (Config[s] != null) {
						Config[s] = gameVars[s];
					}
				}
			}
			
			stage.addChild(dialog);
			stage.addChild(log);
			stage.addChild(tip);
			
			//如果UI视图是加载模式，则进行整体加载
			if (StringUtils.isNotEmpty(Config.uiPath)) {
				App.loader.loadDB(Config.uiPath, new Handler(onUIloadComplete));
			}
		}
		
		private static function onUIloadComplete(content:*):void {
			View.xmlMap = content;
		}
		
		/**获得资源路径(此处可以加上资源版本控制)*/
		public static function getResPath(url:String):String {
			return /^http:\/\//g.test(url) ? url : Config.resPath + url;
		}
	}
}