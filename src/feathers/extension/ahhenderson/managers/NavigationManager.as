package feathers.extension.ahhenderson.managers
{

	import flash.events.EventDispatcher;
	
	import ahhenderson.core.ui.enums.LayoutDirectionType;
	import ahhenderson.core.util.StringUtil;
	
	import feathers.controls.Drawers;
	import feathers.controls.ScreenNavigator;
	import feathers.extension.ahhenderson.ahhenderson_extension_internal;
	import feathers.extension.ahhenderson.controls.core.FeathersRootContainer;
	import feathers.extension.ahhenderson.helpers.DialogHelper;
	import feathers.extension.ahhenderson.util.ScreenUtil;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import starling.display.DisplayObject;

	use namespace ahhenderson_extension_internal;


	internal class NavigationManager extends EventDispatcher
	{

		private static const _instance:NavigationManager=new NavigationManager(SingletonLock);

		public function get defaultScreenId():String
		{
			return _defaultScreenId;
		}

		public function set defaultScreenId(value:String):void
		{
			_defaultScreenId = value;
		}

		private function get fmgr():FeathersApplicationManager
		{
			if(!_fmgr)
				_fmgr = FeathersApplicationManager.instance;
			
			return _fmgr;
		}

		/**
		 *
		 * @return
		 */
		public static function get instance():NavigationManager
		{

			return _instance;
		}

		/**
		 *
		 * @param lock
		 * @throws Error
		 */
		public function NavigationManager(lock:Class)
		{

			if (lock != SingletonLock)
			{
				throw new Error("Invalid Singleton access.  Use Model.instance.");
			}
		}

		private var _isInitialized:Boolean;

		private var _rootContainer:FeathersRootContainer;

		private var _transitionManager:ScreenSlidingStackTransitionManager;

		private var _defaultScreenId:String;
		
		
		public function showDefaultScreen(delay:int=0):void{
			
			if(!this.defaultScreenId)
				return;
			
			ScreenUtil.showScreen(this.screenNavigator, this.defaultScreenId, delay);
		}
		
		public function addScreen(id:String, screen:Object, events:Object=null, initializer:Object=null):void
		{

			ScreenUtil.addScreen(this.screenNavigator, id, screen, events, initializer);
		}

		public function changeDrawerDockMode(location:LayoutDirectionType, dockMode:String):void
		{

			validateManager();

			// Use logic below dierectly after testing.
			var drawerDisplayObjectProperty:String=location.value.toLowerCase() + "Drawer";
			var drawerDockModeProperty:String=location.value.toLowerCase() + "DrawerDockMode";

			// Ensure drawer exists
			if (!this._rootContainer.drawers[drawerDisplayObjectProperty])
				throw new Error("No " + location.value + " was created.");

			this._rootContainer.drawers[drawerDockModeProperty]=dockMode;

		}

		public function initialize(rootScreen:FeathersRootContainer, defaultScreenId:String=null):void
		{

			if(defaultScreenId) 
				this._defaultScreenId=defaultScreenId;
			
			this._rootContainer=rootScreen;

			// Set transition animation
			this._transitionManager=new ScreenSlidingStackTransitionManager(this._rootContainer.screenNavigator);
			this._transitionManager.duration=0.4;

			_isInitialized=true;
		}

		public function initializeDrawer(location:LayoutDirectionType, drawer:DisplayObject, dockMode:String=Drawers.DOCK_MODE_NONE, overwrite:Boolean=false):void
		{

			validateManager();

			// Use logic below dierectly after testing.
			var drawerDisplayObjectProperty:String=location.value.toLowerCase() + "Drawer";
			var drawerDockModeProperty:String=location.value.toLowerCase() + "DrawerDockMode";

			// Ensure drawer exists
			if (!overwrite && this._rootContainer.drawers[drawerDisplayObjectProperty])
				throw new Error("You must overwrite the drawer in the location " + location.value + ".");

			this._rootContainer.drawers[drawerDisplayObjectProperty]=drawer;
			this._rootContainer.drawers[drawerDockModeProperty]=dockMode;

		}

		public function get isInitialized():Boolean
		{

			return _isInitialized;
		}

		public function toggleHeaderVisibility(isVisible:Boolean):void{
			
			this._rootContainer.toggleHeaderVisibility(isVisible);
		}
		
		private var _fmgr:FeathersApplicationManager;
		
		 
		public function showScreen(id:String, resetHeader:Boolean= true):void
		{
			if(!this._rootContainer.screenNavigator.getScreen(id)){
				DialogHelper.showAlert("Screen not Available", "A screen has not been configured for " + id);
				return;
			}

			validateManager();

			if(resetHeader)
				clearHeaderItems();
			
			this.fmgr.logger.trace(this, "Showing screen with id: " + id);
			
			this._rootContainer.screenNavigator.showScreen(id);
		}

		private function clearHeaderItems():void
		{

			if (this._rootContainer.header.rightItems)
				this._rootContainer.header.rightItems=null;

			if (this._rootContainer.header.leftItems)
				this._rootContainer.header.leftItems=null;
		}

		public function toggleDrawer(location:LayoutDirectionType, duration:Number=NaN):void
		{

			validateManager();

			var drawerDisplayObjectProperty:String=location.value.toLowerCase() + "Drawer"

			var toggleDrawerMethod:String="toggle";
			toggleDrawerMethod+=StringUtil.capitalize(location.value.toLowerCase());
			toggleDrawerMethod+="Drawer";

			// Ensure drawer exists
			if (!this._rootContainer.drawers[drawerDisplayObjectProperty])
				throw new Error("No " + location.value + " was created.");

			// Show drawer
			this._rootContainer.drawers[toggleDrawerMethod](duration);

		}

		ahhenderson_extension_internal function get drawers():Drawers
		{

			validateManager();

			return this._rootContainer.drawers;
		}

		ahhenderson_extension_internal function get screenNavigator():ScreenNavigator
		{

			validateManager();

			return this._rootContainer.screenNavigator;
		}

		ahhenderson_extension_internal function validateManager():void
		{

			if (!_isInitialized)
				throw new Error("NavigationManager: You must initialize the manager first");
		}

		public function updateLeftHeaderItems(items:Vector.<DisplayObject>):void
		{

			validateManager();

			if (items)
				this._rootContainer.header.leftItems=items;

		}

		public function updateRightHeaderItems(items:Vector.<DisplayObject>):void
		{

			validateManager();

			if (items)
				this._rootContainer.header.rightItems=items;

		}

		public function updateHeaderTitle(title:String):void
		{

			validateManager();

			if (title)
				this._rootContainer.updateTitle(title);

		}
	}
}


class SingletonLock
{
}
