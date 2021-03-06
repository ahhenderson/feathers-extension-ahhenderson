package feathers.extension.ahhenderson.managers
{

	import flash.events.EventDispatcher;
	import flash.events.LocationChangeEvent;
	import flash.text.engine.BreakOpportunity;
	
	import ahhenderson.core.ui.enums.LayoutDirectionType;
	import ahhenderson.core.ui.layout.HorizontalAlign;
	import ahhenderson.core.util.StringUtil;
	
	import feathers.controls.Drawers;
	import feathers.controls.Header;
	import feathers.controls.ScreenNavigator;
	import feathers.extension.ahhenderson.ahhenderson_extension_internal;
	import feathers.extension.ahhenderson.controls.core.FeathersRootContainer;
	import feathers.extension.ahhenderson.controls.screens.drawers.TopDrawer;
	import feathers.extension.ahhenderson.helpers.DialogHelper;
	import feathers.extension.ahhenderson.util.ScreenUtil;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
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
		
		private var _isHeaderDocked:Boolean;
		
		
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

		public function toggleHeaderDockingMode(docked:Boolean=false):void{
			 
			_isHeaderDocked=docked;
			
			if(!this._rootContainer){
				
				//DialogHelper.showAlert("Method not available at this time", "toggleHeaderDockingMode");
				return;
			}
			trace("Docked..", docked);
			if(this._rootContainer.headerDockingMode != docked) 
				this._rootContainer.headerDockingMode = docked;
		}
		
		private function onDrawerFadeOutTweenComplete():void {
			
			var drawer:TopDrawer = getDrawer(LayoutDirectionType.TOP);
			drawer.touchable = false;
			drawer.visible = false;
			 
		}
		
		private function onDrawerFadeInTweenComplete():void {
			
			var drawer:TopDrawer = getDrawer(LayoutDirectionType.TOP);
			drawer.touchable = true;
			 
		}
		
		private function onHeaderFadeOutTweenComplete():void {
			
			var drawer:TopDrawer = getDrawer(LayoutDirectionType.TOP);
			drawer.header.touchable = false;
			drawer.header.visible = false;
			
		}
		
		private function onHeaderFadeInTweenComplete():void {
			
			var drawer:TopDrawer = getDrawer(LayoutDirectionType.TOP);
			drawer.header.touchable = true;
			
		}
		 
		public function toggleHeaderVisibility(visible:Boolean):void{
			
			var drawer:TopDrawer = getDrawer(LayoutDirectionType.TOP);
			 
			if(visible){
				
				// Already visible
				if(drawer.visible && (drawer.alpha == 1))
					return;
				
				drawer.touchable = false;
				drawer.alpha = 0;
				drawer.visible = true;   
				Starling.juggler.tween( drawer, .20, { transition: Transitions.EASE_IN_OUT, alpha: 1, onComplete: onDrawerFadeInTweenComplete });
			}
			else{
				
				// Already hidden
				if(!drawer.visible)
					return;
				
				drawer.touchable = false;
				Starling.juggler.tween( drawer, .25, { transition: Transitions.EASE_IN_OUT, alpha: 0, onComplete: onDrawerFadeInTweenComplete }); 
			} 
		}
		
		private var _fmgr:FeathersApplicationManager;
		
		
		public function showScreen(id:String, resetHeader:Boolean= true, transition:Function=null):void
		{ 
			 
			if(_isHeaderDocked != this._rootContainer.headerDockingMode)
				this._rootContainer.headerDockingMode =_isHeaderDocked;
			 
			if(!this._rootContainer.screenNavigator.getScreen(id)){
				DialogHelper.showAlert("Screen not Available", "A screen has not been configured for " + id);
				return;
			}

			validateManager();
  
			if(resetHeader){
				
				this.fmgr.logger.trace(this, "Resetting headers for screen id: " + id);
				
				var drawer:TopDrawer = getDrawer(LayoutDirectionType.TOP) as TopDrawer;
				 
				if (drawer.header){
					
					drawer.header.leftItems=null;
					drawer.header.rightItems=null;
					drawer.header.centerItems=null;
				} 
			}
			
			this.fmgr.logger.trace(this, "Showing screen with id: " + id);
			 
			this._rootContainer.screenNavigator.showScreen(id, transition);
		}
  
		private function getDrawer(location:LayoutDirectionType):*{
			
			var drawerDisplayObjectProperty:String=location.value.toLowerCase() + "Drawer"
				
			// Ensure drawer exists
			if (!this._rootContainer.drawers[drawerDisplayObjectProperty])
				throw new Error("No " + location.value + " was created.");
			
			return this._rootContainer.drawers[drawerDisplayObjectProperty];
			
		}
		
		 
		public function clearHeaderItems(position:String):void{
			
			validateManager();
			
			if(!position){
				fmgr.logger.log("{0}: Postion param is null", "clearHeaderItems");
				return;
			}
			
			var drawer:TopDrawer = getDrawer(LayoutDirectionType.TOP) as TopDrawer;
			var propertyName:String;
			
			if(!drawer || !drawer.header) 
				return;
		  
			switch(position){
				
				case HorizontalAlign.LEFT:
					propertyName = "leftItems"
					break;
				
				case HorizontalAlign.RIGHT:
					propertyName = "rightItems";
					break;
				
				case HorizontalAlign.CENTER:
					propertyName = "centerItems";
					break;
			}
			
			if (propertyName && drawer.header.hasOwnProperty(propertyName)){
				 
				drawer.header[propertyName]=null;  
			}
		}
		
		public function toggleDrawer(location:LayoutDirectionType, duration:Number=NaN):void
		{
 
			validateManager();

			var drawerDockModeProperty:String=location.value.toLowerCase() + "DrawerDockMode";
			var drawerDisplayObjectProperty:String=location.value.toLowerCase() + "Drawer"

			var toggleDrawerMethod:String="toggle";
			toggleDrawerMethod+=StringUtil.capitalize(location.value.toLowerCase());
			toggleDrawerMethod+="Drawer";

			// Ensure drawer exists
			if (!this._rootContainer.drawers[drawerDisplayObjectProperty])
				throw new Error("No " + location.value + " was created.");

			// Show drawer
			
			// Handle Top location differently
			if(location == LayoutDirectionType.TOP){
				
				var dockMode:String = this._rootContainer.drawers[drawerDockModeProperty];
				var targetDockMode:String;
				
				switch(dockMode){
					
					case Drawers.DOCK_MODE_PORTRAIT:
						targetDockMode = Drawers.DOCK_MODE_NONE;
						break;
					
					case Drawers.DOCK_MODE_NONE:
						targetDockMode = Drawers.DOCK_MODE_PORTRAIT;
						break; 
				}
				  
				this._rootContainer.drawers[drawerDockModeProperty]=targetDockMode;
				return;
			}
			
			// Left menu
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
			if (items) 
				updateHeaderItems(items, HorizontalAlign.LEFT);
		}
		
		public function updateCenterHeaderItems(items:Vector.<DisplayObject>):void
		{  
			if (items) 
				updateHeaderItems(items, HorizontalAlign.CENTER);
		}
		
		private function updateHeaderItems(items:Vector.<DisplayObject>, position:String):void{
			
			validateManager();
			
			if(!position){
				fmgr.logger.log("{0}: Postion param is null", "updateHeaderItems");
				return;
			}
			
			var drawer:TopDrawer = getDrawer(LayoutDirectionType.TOP) as TopDrawer;
			var propertyName:String;
			 
			if(!drawer || !drawer.header) 
				return;
			
			switch(position){
				
				case HorizontalAlign.LEFT:
					propertyName = "leftItems"
					break;
				
				case HorizontalAlign.RIGHT:
					propertyName = "rightItems";
					break;
				
				case HorizontalAlign.CENTER:
					propertyName = "centerItems";
					break;
			}
			 
			if (items && propertyName && drawer.header.hasOwnProperty(propertyName)){
				
				drawer.header.alpha = 0;   
				drawer.header[propertyName]=items; 
				drawer.header.touchable = false;
				
				Starling.juggler.tween( drawer.header, .20, { transition: Transitions.EASE_IN_OUT, alpha: 1, onComplete: onHeaderFadeInTweenComplete });
				
			}
		}

		public function updateRightHeaderItems(items:Vector.<DisplayObject>):void
		{  
			if (items) 
				updateHeaderItems(items, HorizontalAlign.RIGHT); 
		}

		public function updateHeaderTitle(title:String):void
		{
			validateManager();
 
			var drawer:TopDrawer = getDrawer(LayoutDirectionType.TOP) as TopDrawer;
			var propertyName:String;
			
			if(!drawer || !drawer.header) 
				return; 
			
			drawer.header.alpha = 0;
			drawer.header.title = title;
			
			// Animate
			Starling.juggler.tween( drawer.header, .20, { transition: Transitions.EASE_IN_OUT, alpha: 1, onComplete: onHeaderFadeInTweenComplete });
			 
		}
		
		public function getHeaderHeight():Number{
			
			if(this._rootContainer.header){
				return this._rootContainer.header.height;
			}
			
			return NaN;
		}
	}
}


class SingletonLock
{
}
