//------------------------------------------------------------------------------
//
//   Anthony Henderson  Copyright 2012 
//   All rights reserved. 
//
//------------------------------------------------------------------------------

package feathers.extension.ahhenderson.helpers {

	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.List;
	import feathers.controls.Panel;
	import feathers.controls.PickerList;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_StyleNameConstants;
	import feathers.extension.ahhenderson.controls.DateTimePicker;
	import feathers.extension.ahhenderson.controls.TitledTextBlock;
	import feathers.extension.ahhenderson.enums.FeathersComponentPoolType;
	import feathers.extension.ahhenderson.themes.pool.BaseFlatThemePoolFunctions;
	import feathers.layout.AnchorLayoutData;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import starling.textures.TextureSmoothing;


	public class UiFactoryHelper {

		include "_Helpers.inc";

		public static function buttonFactory( label:String = null, customStyleName:String = null ):Button {

			var button:Button = fmgr.pool.borrowObj( FeathersComponentPoolType.BUTTON );

			if ( label )
				button.label = label;

			if ( customStyleName )
				button.styleNameList.add( customStyleName );

			return button;
		}

		public static function defaultFooterFactory( title:String = null, customStyleName:String = null ):Header {

			var footer:Header = fmgr.pool.borrowObj( FeathersComponentPoolType.HEADER ) as Header;

			if ( customStyleName ) {
				footer.styleNameList.add( customStyleName );
			}

			if ( title ) {
				footer.title = title;
			}
			return footer;
		}

		public static function defaultItemRendererFactory( labelField:String = "labelField" ):IListItemRenderer {

			var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = labelField;
			renderer.isQuickHitAreaEnabled = true;
			return renderer;
		}

		public static function formControlListFactory( visible:Boolean = true, selectable:Boolean = false, hasElasticEdges:Boolean = false,
													   itemRenderFactory:Function = null ):List {

			var list:List = new List();
			list.visible = visible;
			list.isSelectable = selectable;
			list.hasElasticEdges = hasElasticEdges
			list.itemRendererFactory = ( itemRenderFactory ) ? itemRenderFactory : UiFactoryHelper.formLabelItemRendererFactory;

			return list;
		}

		public static function formLabelItemRendererFactory( labelField:String = "labelField" ):IListItemRenderer {

			var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = labelField;
			renderer.isQuickHitAreaEnabled = false;
			renderer.styleNameList.add( FeathersExtLib_StyleNameConstants.FORM_LABEL_LIST_ITEM_RENDERER );
			return renderer;
		}

		public static function imageLoaderFactory( noSmoothing:Boolean = false ):ImageLoader {

			var image:ImageLoader = new ImageLoader(); //fmgr.pool.borrowObj(FeathersComponentPoolType.IMAGE_LOADER);

			image.textureScale = 1; //fmgr.theme.scaledResolution;

			if ( noSmoothing )
				image.smoothing = TextureSmoothing.NONE;

			//image.resetObjectFunction = BaseFlatThemePoolFunctions.resetImageLoaderObject;

			return image;
		}

		public static function panelFactory( title:String = null, customHeaderFactory:String = null ):Panel {

			var panel:Panel = new Panel(); //fmgr.pool.borrowObj(FeathersComponentPoolType.IMAGE_LOADER);

			/*if(customHeaderFactory)
				panel.customHeaderStyleName = (customHeaderFactory) ? customHeaderFactory : CustomFlatTheme.PANEL_HEADER__DARK_TITLE;
			*/
			if ( title )
				panel.title = title;

			return panel;
		}

		public static function pickerListFactory( customStyleName:String = null,  
												  labelField:String = "labelField", 
												  typicalItem:String ="XXXXXXXXX", 
												  itemRendererFactory:IListItemRenderer = null,  
												  prompt:String = "Select an Item", 
												  listHeight:int = 250 ):PickerList {
			
			var control:PickerList = fmgr.pool.borrowObj( FeathersComponentPoolType.PICKER_LIST );
			
			// Defaults 
			control.listProperties.itemRendererFactory = UiFactoryHelper.defaultItemRendererFactory;
			control.styleNameList.add( FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_DARK );
			
			if ( customStyleName ) {
				control.styleNameList.add( customStyleName );
			}
			
			if ( itemRendererFactory ) {
				control.listProperties.itemRendererFactory = UiFactoryHelper.defaultItemRendererFactory;
			}
			
			// Defined
			control.prompt = prompt;
			control.labelField = labelField;
			control.listProperties.typicalItem = typicalItem;
			control.listProperties.height = listHeight * fmgr.theme.scaledResolution;
			
			return control;
		}
		
		public static function dateTimePickerFactory( customStyleName:String = null,  
												  labelField:String = "labelField", 
												  typicalItem:String ="XXXXXXXXX", 
												  itemRendererFactory:IListItemRenderer = null,  
												  prompt:String = "Select Date/Time", 
												  contentHeight:int = 250 ):DateTimePicker {

			var control:DateTimePicker = new DateTimePicker();// = fmgr.pool.borrowObj( FeathersComponentPoolType.PICKER_LIST );

			// Defaults 
			//control.listProperties.itemRendererFactory = UiFactoryHelper.defaultItemRendererFactory;
			control.styleNameList.add( FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_DARK );

			if ( customStyleName ) {
				control.styleNameList.add( customStyleName );
			}

			/*if ( itemRendererFactory ) {
				control.listProperties.itemRendererFactory = UiFactoryHelper.defaultItemRendererFactory;
			}*/

			// Defined
			control.prompt = prompt;
			control.labelField = labelField;
			control.pickerContentProperties.typicalItem = typicalItem;
			control.pickerContentProperties.height = contentHeight * fmgr.theme.scaledResolution;
			 
			return control;
		}

		public static function screenNavigatorFactory( transitionDuration:Number = 0.2, clipContent:Boolean = true ):ScreenNavigator {

			// Get from Pool
			var navigator:ScreenNavigator = fmgr.pool.borrowObj( FeathersComponentPoolType.SCREEN_NAVIGATOR );
			navigator.clipContent = clipContent;

			// Set transition
			var transitionManager:ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager( navigator );
			transitionManager.duration = transitionDuration;

			// Set reset function 
			navigator.resetObjectFunction = BaseFlatThemePoolFunctions.resetScreenNavigatorObject;

			return navigator;
		}

		public static function scrollingFooterFactor():ScrollContainer {

			var container:ScrollContainer = new ScrollContainer();
			container.styleNameList.add( ScrollContainer.ALTERNATE_STYLE_NAME_TOOLBAR );
			container.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			container.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			return container;

		}

		public static function textInputFactory( prompt:String = null, maxChars:int = -1, restrict:String = null, isPassword:Boolean =
			false, customStyleName:String = null ):TextInput {

			var textInput:TextInput = fmgr.pool.borrowObj( FeathersComponentPoolType.TEXT_INPUT );

			if ( maxChars > 0 )
				textInput.maxChars = maxChars;

			if ( prompt )
				textInput.prompt = prompt;

			if ( restrict )
				textInput.restrict = restrict;

			if ( isPassword )
				textInput.displayAsPassword = true;

			if ( customStyleName )
				textInput.styleNameList.add( customStyleName );

			return textInput;
		}

		public static function titledTextBlockFactory( title:String, content:String, layoutData:AnchorLayoutData = null,
													   autoSizeMode:String = "stage" ):TitledTextBlock {

			// Add Text block  
			var control:TitledTextBlock = new TitledTextBlock(); //fmgr.pool.borrowObj( CustomComponentPoolType.TITLED_TEXT_BLOCK );

			// Either 'stage', 'content'
			control.autoSizeMode = autoSizeMode;

			if ( !layoutData ) {
				control.layoutData = new AnchorLayoutData( NaN, NaN, NaN, NaN, 0, 0 );
			}

			control.title = title;
			control.content = content;

			return control;

		}
	}
}
