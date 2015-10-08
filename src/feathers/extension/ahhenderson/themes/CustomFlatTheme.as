package feathers.extension.ahhenderson.themes {

	import flash.geom.Rectangle;
	import flash.text.engine.ElementFormat;
	
	import ahhenderson.core.managers.ObjectPoolManager;
	
	import feathers.controls.Button;
	import feathers.controls.DateTimeSpinner;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Panel;
	import feathers.controls.PickerList;
	import feathers.controls.SpinnerList;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleButton;
	import feathers.controls.popups.CalloutPopUpContentManager;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale9Image;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_StyleNameConstants;
	import feathers.extension.ahhenderson.constants.FeathersExtLib_ThemeConstants;
	import feathers.extension.ahhenderson.controls.DateSelector;
	import feathers.extension.ahhenderson.controls.IconLabel;
	import feathers.extension.ahhenderson.controls.PanelNavigator;
	import feathers.extension.ahhenderson.controls.TitledTextBlock;
	import feathers.extension.ahhenderson.controls.popUps.CustomBottomDrawerPopUpManager;
	import feathers.extension.ahhenderson.enums.CustomComponentPoolType;
	import feathers.extension.ahhenderson.helpers.AssetHelper;
	import feathers.extension.ahhenderson.helpers.LayoutHelper;
	import feathers.extension.ahhenderson.themes.constants.FlatThemeBaseTextures;
	import feathers.extension.ahhenderson.themes.constants.FlatThemeCustomTextures;
	import feathers.extension.ahhenderson.themes.pool.BaseFlatThemePoolFunctions;
	import feathers.extension.ahhenderson.themes.pool.CustomFlatThemePoolFunctions;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.system.DeviceCapabilities;
	import feathers.textures.Scale9Textures;
	import feathers.utils.math.roundToNearest;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.textures.SubTexture;
	import starling.textures.Texture;


	public class CustomFlatTheme extends BaseFlatTheme {
		public function CustomFlatTheme( properties:Object = null, scaleToDPI:Boolean = true ) {

			super( properties, scaleToDPI );
		}

		/**
		 *
		 * @default
		 */

		// NEW CODE
		protected var spinnerListSelectionCustomOverlaySkinTextures:Scale9Textures;

		protected static const SPINNER_LIST_SELECTION_CUSTOM_OVERLAY_SCALE9_GRID:Rectangle = new Rectangle( 8, 8, 184, 84 ); //new Rectangle(11, 11, 2, 2);

		protected var buttonSocialFbUpSkinTextures:Scale9Textures;

		protected var buttonSocialFbDownSkinTextures:Scale9Textures;

		protected var buttonSocialTwitterUpSkinTextures:Scale9Textures;

		protected var buttonSocialTwitterDownSkinTextures:Scale9Textures;

		protected var buttonSocialGoogPlusUpSkinTextures:Scale9Textures;

		protected var buttonSocialGoogPlusDownSkinTextures:Scale9Textures;
		
		/**
		 * An ElementFormat with a dark tint meant for UI controls.
		 */
		protected var darkFormLabelElementFormat:ElementFormat;
		
		protected var darkFormTextElementFormat:ElementFormat;
		
		protected var darkFormPromptElementFormat:ElementFormat;
		
		protected var lightFormLabelElementFormat:ElementFormat;
		
		protected var lightFormTextElementFormat:ElementFormat;
		
		protected var lightFormPromptElementFormat:ElementFormat;

		/**
		 * Initializes the theme colors. Expected to be called by subclasses after the
		 * assets have been loaded and the skin texture atlas has been created.
		 */
		override public function preinitializeThemeParams():void {
			
			super.preinitializeThemeParams();
			 
			// FORM THEME COLORS
			LIGHT_FORM_LABEL_COLOR  = getThemePropertyValue(this.themeProperties.LIGHT_FORM_LABEL_COLOR, 0xe5e5e5); 
			LIGHT_FORM_TEXT_COLOR  = getThemePropertyValue(this.themeProperties.LIGHT_FORM_TEXT_COLOR, 0xe5e5e5);
			LIGHT_FORM_PROMPT_COLOR  = getThemePropertyValue(this.themeProperties.LIGHT_FORM_PROMPT_COLOR, 0xe5e5e5);
			
			DARK_FORM_LABEL_COLOR  = getThemePropertyValue(this.themeProperties.DARK_FORM_LABEL_COLOR, 0x444444);
			DARK_FORM_TEXT_COLOR  = getThemePropertyValue(this.themeProperties.DARK_FORM_TEXT_COLOR, 0x040404);
			DARK_FORM_PROMPT_COLOR  = getThemePropertyValue(this.themeProperties.DARK_FORM_PROMPT_COLOR, 0xCCCCCC);
			
			
		}
		override protected function initializeFonts():void{
			
			super.initializeFonts();
			
			this.darkFormLabelElementFormat = new ElementFormat( this.boldFontDescription, this.regularFontSize, DARK_FORM_LABEL_COLOR );
			this.darkFormTextElementFormat = new ElementFormat( this.regularFontDescription, this.regularFontSize, DARK_FORM_TEXT_COLOR );
			this.darkFormPromptElementFormat = new ElementFormat( this.regularFontDescription, this.regularFontSize, DARK_FORM_PROMPT_COLOR );
			this.lightFormLabelElementFormat = new ElementFormat( this.boldFontDescription, this.regularFontSize, LIGHT_FORM_LABEL_COLOR );
			this.lightFormTextElementFormat = new ElementFormat( this.regularFontDescription, this.regularFontSize, LIGHT_FORM_TEXT_COLOR );
			this.lightFormPromptElementFormat = new ElementFormat( this.regularFontDescription, this.regularFontSize, LIGHT_FORM_PROMPT_COLOR );
			
		}
		override protected function initializeStyleProviders():void {

			super.initializeStyleProviders();

			// Buttons
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.BUTTON_ALTERNATE_NAME_SOCIAL_FACEBOOK,
																			 this.setSocialFbButtonStyles );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.BUTTON_ALTERNATE_NAME_SOCIAL_TWITTER,
																			 this.setSocialTwitterButtonStyles );
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.BUTTON_ALTERNATE_NAME_SOCIAL_GOOGLE_PLUS,
																			 this.setSocialGoogPlusButtonStyles );
			
			
			// Titled Text Block
			this.getStyleProviderForClass( TitledTextBlock ).defaultStyleFunction = this.setTitledTextBlockStyles;

			// Date Selector
			this.getStyleProviderForClass( DateSelector ).defaultStyleFunction = this.setDateSelectorStyles;

			// Icon label
			this.getStyleProviderForClass( IconLabel ).defaultStyleFunction = this.setIconLabelStyles;

			// PanelNavigator 
			this.getStyleProviderForClass( PanelNavigator ).defaultStyleFunction = this.setPanelNavigatorStyles;

			// PickerList 
			this.getStyleProviderForClass( PickerList ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_LIGHT,
																				 setPickerListTransparentLightStyles )
			this.getStyleProviderForClass( PickerList ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_DARK,
																				 setPickerListTransparentDarkStyles )
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_LIGHT_BUTTON,
																			 this.setPickerListTransparentLightButtonStyles )
			this.getStyleProviderForClass( Button ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_DARK_BUTTON,
																			 this.setPickerListTransparentDarkButtonStyles )
			this.getStyleProviderForClass( List ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_LIST,
																		   this.setPickerListTransparentListStyles );
			this.getStyleProviderForClass( Panel ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_POPUP_PANEL,
																			setPickerListTransparentPopUpPanelStyles )
				
			// PickerList - DateTime
			this.getStyleProviderForClass( PickerList ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.PICKER_LIST_DATETIME__TRANSPARENT_LIGHT,
				setPickerListDateTimeStyles )
			
			// Custom spinner 
			this.getStyleProviderForClass( SpinnerList ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.SPINNER_LIST__ALTERNATE_OVERLAY,
																				  setCustomSpinnerListStyles )

			// Item Renderers
			this.getStyleProviderForClass( DefaultListItemRenderer ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.FORM_LABEL_LIST_ITEM_RENDERER,
																							  setItemRendererFormLabelStyles )
			this.getStyleProviderForClass( DefaultListItemRenderer ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.FORM_LABEL_LIST_DRILL_DOWN_ITEM_RENDERER,
																							  setItemRendererFormLabelDrillDownStyles )
			this.getStyleProviderForClass( DefaultListItemRenderer ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.ARROW_LABEL_LIST_ITEM_RENDERER,
																							  setItemRendererArrowLabelStyles )

			this.getStyleProviderForClass( TitledTextBlock ).setFunctionForStyleName( TitledTextBlock.TITLED_TEXT_BLOCK_ITEM_RENDERER,
																					  this.setTitledTextBlockItemRendererStyles );

			// Header
			this.getStyleProviderForClass( Header ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.HEADER_TITLED_NAVIGATOR_SCREEN,
																			 setTitledNavigationHeaderStyles );
			//this.getStyleProviderForClass( Header).setFunctionForStyleName(PANEL_HEADER__DARK_TITLE, setPanelHeaderStyles);

			// labels
			this.getStyleProviderForClass( Label ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.LABEL_ALTERNATE_DARK_STYLE_NAME_NORMAL,
																			this.setDarkLabelStyles );
			this.getStyleProviderForClass( Label ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.LABEL_ALTERNATE_DARK_STYLE_NAME_HEADING,
																			this.setHeadingDarkLabelStyles );
			this.getStyleProviderForClass( Label ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.LABEL_ALTERNATE_DARK_STYLE_NAME_DETAIL,
																			this.setDetailDarkLabelStyles );
			// Labels - Form
			this.getStyleProviderForClass( Label ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.LABEL_FORM_DARK, this.setFormLabelDarkStyles );
			
			this.getStyleProviderForClass( Label ).setFunctionForStyleName( FeathersExtLib_StyleNameConstants.LABEL_FORM_LIGHT, this.setFormLabelLightStyles);
			
			// Text Input
			this.getStyleProviderForClass( TextInput ).setFunctionForStyleName(  FeathersExtLib_StyleNameConstants.TEXT_INPUT_TRANSPARENT_FORM_DARK,
				this.setTextInputTransparentFormDarkStyles);
			
			this.getStyleProviderForClass( TextInput ).setFunctionForStyleName(  FeathersExtLib_StyleNameConstants.TEXT_INPUT_TRANSPARENT_FORM_LIGHT,
				this.setTextInputTransparentFormLightStyles);
			
		}

		/**
		 * Initializes the textures by extracting them from the atlas and
		 * setting up any scaling grids that are needed.
		 */
		override protected function initializeTextures():void {

			super.initializeTextures();

			this.buttonSocialFbUpSkinTextures =
				new Scale9Textures( fmgr.theme.assetManager.getTexture( FlatThemeBaseTextures.BUTTON_SOCIAL_FB_UP_SKIN ),
																		BUTTON_SCALE9_GRID );
			this.buttonSocialFbDownSkinTextures =
				new Scale9Textures( fmgr.theme.assetManager.getTexture( FlatThemeBaseTextures.BUTTON_SOCIAL_FB_DOWN_SKIN ),
																		BUTTON_SCALE9_GRID );

			this.buttonSocialGoogPlusUpSkinTextures =
				new Scale9Textures( fmgr.theme.assetManager.getTexture( FlatThemeBaseTextures.BUTTON_SOCIAL_GPLUS_UP_SKIN ),
																		BUTTON_SCALE9_GRID );
			this.buttonSocialGoogPlusDownSkinTextures =
				new Scale9Textures( fmgr.theme.assetManager.getTexture( FlatThemeBaseTextures.BUTTON_SOCIAL_GPLUS_DOWN_SKIN ),
																		BUTTON_SCALE9_GRID );

			this.spinnerListSelectionCustomOverlaySkinTextures =
				new Scale9Textures( fmgr.theme.assetManager.getTexture( FlatThemeBaseTextures.SPINNER_OVERLAY ),
																		SPINNER_LIST_SELECTION_CUSTOM_OVERLAY_SCALE9_GRID );

		}

		override protected function initializeObjectPools():void {

			super.initializeObjectPools();

			// For Pooling dimensions
			CustomFlatThemePoolFunctions.initializeDimensions( this.themeProperties, this.scale );

			ObjectPoolManager.instance.createPool( CustomComponentPoolType.TITLED_TEXT_BLOCK, null, 5 );
			ObjectPoolManager.instance.createPool( CustomComponentPoolType.ICON_LABEL, null, 5 );
		}

		//-------------------------
		// Buttons
		//-------------------------

		protected function setSocialButtonStyles( button:Button, icon:String, upTextures:Scale9Textures = null,
												  downTextures:Scale9Textures = null, disabledTextures:Scale9Textures = null ):void {

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = upTextures;
			skinSelector.setValueForState( downTextures, Button.STATE_DOWN, false );
			skinSelector.setValueForState( disabledTextures, Button.STATE_DISABLED, false );
			skinSelector.displayObjectProperties = { width: this.controlSize, height: this.controlSize, textureScale: this.scale };

			button.stateToSkinFunction = skinSelector.updateValue;

			this.setBaseButtonStyles( button );

			button.defaultIcon = AssetHelper.getImage( icon );

		}

		protected function setSocialFbButtonStyles( button:Button ):void {

			setSocialButtonStyles( button,
								   FlatThemeCustomTextures.ICONS_SOCIAL_FACEBOOK,
								   this.buttonSocialFbUpSkinTextures,
								   this.buttonSocialFbDownSkinTextures,
								   this.buttonDisabledSkinTextures );

		/*var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.buttonSocialFbUpSkinTextures;
		skinSelector.setValueForState( this.buttonSocialFbDownSkinTextures, Button.STATE_DOWN, false );
		skinSelector.setValueForState( this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false );
		skinSelector.displayObjectProperties = { width: this.controlSize, height: this.controlSize, textureScale: this.scale };
		button.stateToSkinFunction = skinSelector.updateValue;

		this.setBaseButtonStyles( button );

		button.defaultIcon = AssetHelper.getImage(FlatThemeCustomTextures.ICONS_SOCIAL_FACEBOOK);*/
		}

		protected function setSocialGoogPlusButtonStyles( button:Button ):void {

			setSocialButtonStyles( button,
								   FlatThemeCustomTextures.ICONS_SOCIAL_GOOGLE_PLUS,
								   this.buttonSocialGoogPlusUpSkinTextures,
								   this.buttonSocialGoogPlusDownSkinTextures,
								   this.buttonDisabledSkinTextures );

		/*var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.buttonSocialGoogPlusUpSkinTextures;
		skinSelector.setValueForState( this.buttonSocialGoogPlusDownSkinTextures, Button.STATE_DOWN, false );
		skinSelector.setValueForState( this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false );
		skinSelector.displayObjectProperties = { width: this.controlSize, height: this.controlSize, textureScale: this.scale };
		button.stateToSkinFunction = skinSelector.updateValue;

		this.setBaseButtonStyles( button );

		button.defaultIcon = AssetHelper.getImage(FlatThemeCustomTextures.ICONS_SOCIAL_GOOGLE_PLUS);*/
		}

		protected function setSocialTwitterButtonStyles( button:Button ):void {

			this.setButtonStyles( button );

			button.defaultIcon = AssetHelper.getImage( FlatThemeCustomTextures.ICONS_SOCIAL_TWITTER_BIRD );
		}

		//-------------------------
		// SpinnerList
		//-------------------------

		protected function setCustomSpinnerListStyles( list:SpinnerList ):void {

			this.setSpinnerListStyles( list );

			list.selectionOverlaySkin = new Scale9Image( this.spinnerListSelectionCustomOverlaySkinTextures, this.scale );

		}

		//-------------------------
		// Custom
		//-------------------------
		protected function setIconLabelStyles( control:IconLabel ):void {

			control.touchable = false;
			control.textRendererProperties.elementFormat = this.lightElementFormat;

			control.resetObjectFunction = CustomFlatThemePoolFunctions.resetIconLabel;
		}

		protected function setTitledTextBlockItemRendererStyles( titledTextBlock:TitledTextBlock ):void {

			setTitledTextBlockStyles( titledTextBlock );

		/*titledTextBlock.titleFormat = this.fontLightItemRenderer;
		titledTextBlock.contentFormat = this.fontLightSmallDetail;*/
		}

		protected function setTitledTextBlockStyles( styledControl:TitledTextBlock ):void {

			styledControl.minWidth = 150 * this.scale;
			styledControl.minHeight = 44 * this.scale;
			styledControl.titleFormat = this.largeLightElementFormat;
			styledControl.contentFormat = this.smallLightElementFormat;

			//styledControl.titleFormat 
			/*titledTextBlock.textFontStyle = VzLabel.FONT_SMALL_SEMI_HIGHLIGHT;
			titledTextBlock.titleFontStyle = VzLabel.FONT_LARGE_DARK;
			titledTextBlock.gap = 6;*/
			/*	iconLabel.height = 150*this.scale;
			iconLabel.width = 30 * this.scale; */

			styledControl.minTouchWidth = 150 * this.scale;
			styledControl.minTouchHeight = 100 * this.scale;

			// IMPORTANT: recommended for object pooling
			styledControl.resetObjectFunction = CustomFlatThemePoolFunctions.resetTitledTextBlock;
		}

		protected function setDateSelectorStyles( styledControl:DateSelector ):void {

			//styledControl.width= roundToNearest(350* this.scale);
			styledControl.minWidth = roundToNearest( 350 * this.scale );
			styledControl.minHeight = roundToNearest( 150 * this.scale );

			//styledControl.resetObjectFunction =  CustomFlatThemePoolFunctions.resetDateSelectorObject(;

		}

		protected function setPanelNavigatorStyles( styledControl:PanelNavigator ):void {

			this.setCustomPanelStyles( styledControl );

		}

		//-------------------------
		// Header
		//-------------------------
		/**
		 *
		 * @param header
		 */
		protected function setTitledNavigationHeaderStyles( header:Header ):void {

			setHeaderStyles( header );

			header.minWidth = this.headerSize;
			header.minHeight = this.headerSize;

			header.padding = 0; //this.smallGutterSize;
			header.gap = 0; //this.smallGutterSize;
			header.titleGap = this.smallGutterSize;
			header.paddingLeft = 2 * fmgr.theme.scaledResolution;
			header.paddingRight = 2 * fmgr.theme.scaledResolution;
			header.paddingTop = 2 * fmgr.theme.scaledResolution;
			header.paddingBottom = 2 * fmgr.theme.scaledResolution;
			header.backgroundSkin = new Quad( 10, 10, 0x000000 );
			header.backgroundSkin.alpha = .2;

			header.titleProperties.elementFormat = this.headerElementFormat;

		}

		/**
		 *
		 * @param header
		 */
		protected function setPanelHeaderStyles( header:Header ):void {

			setPanelScreenHeaderStyles( header );
			//setHeaderStyles(header);
			//setAlertHeaderWithoutBackgroundStyles(header);

			//header.titleProperties.elementFormat = this.headerElementFormatDark;
		}

		//-------------------------
		// Item Renderers
		//-------------------------

		protected function setItemRendererFormLabelStyles( renderer:BaseDefaultItemRenderer ):void {

			// Skin
			var alteredScale:Number = 1;
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.defaultSelectedValue = this.itemRendererSelectedSkinTextures;
			skinSelector.setValueForState( this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false );
			skinSelector.displayObjectProperties =
				{ width: this.itemRendererMinSize, height: this.itemRendererMinSize, textureScale: alteredScale };

			renderer.stateToSkinFunction = skinSelector.updateValue;
			/*renderer.stateToSkinFunction = null;
			renderer.defaultSkin = new Quad(10, 10, 0xFFFFFF);//this.itemRendererBackground;
			renderer.defaultSkin.alpha=1;*/

			// Text
			renderer.defaultLabelProperties.elementFormat = this.darkFormLabelElementFormat;
			renderer.downLabelProperties.elementFormat = this.darkFormLabelElementFormat;
			renderer.defaultSelectedLabelProperties.elementFormat = this.darkFormLabelElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.darkFormLabelElementFormat;
			renderer.disabledLabelProperties.alpha = .6;

			// Dimensions
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = renderer.paddingBottom = FeathersExtLib_ThemeConstants.CONTROL_GUTTER / 2;
			renderer.paddingLeft = FeathersExtLib_ThemeConstants.CONTROL_GUTTER * 2;
			renderer.paddingRight = FeathersExtLib_ThemeConstants.CONTROL_GUTTER * 2;
			renderer.gap = FeathersExtLib_ThemeConstants.CONTROL_GUTTER;
			renderer.minWidth = renderer.minHeight = FeathersExtLib_ThemeConstants.ITEM_RENDERER_MIN_SIZE;

			// Touch Dimensions
			LayoutHelper.setTouchBoundaries( renderer );
			renderer.minTouchWidth =
				renderer.minTouchHeight =
				roundToNearest( FeathersExtLib_ThemeConstants.ITEM_RENDERER_MIN_SIZE * FeathersExtLib_ThemeConstants.TOUCH_BOUNDARY_MULTIPLIER );

			// Accessory
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;

			// Icon
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
		}

		protected function setItemRendererArrowLabelStyles( renderer:BaseDefaultItemRenderer ):void {

			setItemRendererFormLabelStyles( renderer );

		/*const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultSelectedValue = this.itemRendererCustom1SelectedSkinTextures;
		skinSelector.setValueForState( this.itemRendererCustom1SelectedSkinTextures, Button.STATE_DOWN, false );
		skinSelector.displayObjectProperties = { width: 44 * this.scale, height: 30 * this.scale, textureScale: this.scale };

		// Update renderer to support state.
		renderer.stateToSkinFunction = skinSelector.updateValue; */

		}

		protected function setItemRendererFormLabelDrillDownStyles( renderer:BaseDefaultItemRenderer ):void {

			setItemRendererFormLabelStyles( renderer );

			// Custom gap
			renderer.gap = roundToNearest( FeathersExtLib_ThemeConstants.CONTROL_GUTTER * 1.5 );

			renderer.layoutOrder = BaseDefaultItemRenderer.LAYOUT_ORDER_LABEL_ACCESSORY_ICON;
			renderer.iconPosition = Button.ICON_POSITION_RIGHT;
			renderer.iconSourceField = "drillDownIcon";
		}

		/**
		 * The pop-up factory for a PickerList creates a DateTimeSpinner.
		 */
		protected static function pickerListDateTimeSpinnerListFactory():DateTimeSpinner
		{
			return new DateTimeSpinner();
		}
		
		//-------------------------
		// Form - Label
		//-------------------------
		protected function setFormLabelDarkStyles( label:Label ):void {
			
			setBaseLabelStyles( label );
			
			label.textRendererProperties.elementFormat = this.darkFormLabelElementFormat;
			label.textRendererProperties.disabledElementFormat = this.darkUIDisabledElementFormat;
		}
		
		protected function setFormLabelLightStyles( label:Label ):void {
			
			setBaseLabelStyles( label );
			
			label.textRendererProperties.elementFormat = this.lightFormLabelElementFormat;
			label.textRendererProperties.disabledElementFormat = this.lightUIDisabledElementFormat;
		}
		
		//-------------------------
		// Label
		//-------------------------
		protected function setDarkLabelStyles( label:Label ):void {

			setBaseLabelStyles( label );

			label.textRendererProperties.elementFormat = this.darkElementFormat;
			label.textRendererProperties.disabledElementFormat = this.darkUIDisabledElementFormat;
		}

		protected function setHeadingDarkLabelStyles( label:Label ):void {

			setBaseLabelStyles( label );

			label.textRendererProperties.elementFormat = this.largeDarkElementFormat;
			label.textRendererProperties.disabledElementFormat = this.largeDisabledElementFormat;
		}

		protected function setDetailDarkLabelStyles( label:Label ):void {

			setBaseLabelStyles( label );

			label.textRendererProperties.elementFormat = this.smallDarkElementFormat;
			label.textRendererProperties.disabledElementFormat = this.smallDisabledElementFormat;
		}

		//-------------------------
		// Label
		//-------------------------
		/**
		 *
		 * @param panel
		 */
		protected function setCustomPanelStyles( panel:Panel ):void {

			this.setScrollerStyles( panel );

			//panel.backgroundSkin = new Scale9Image( this.bg_popup, this.scale );
			panel.backgroundSkin = new Quad( 10, 10, 0x000000 );
			panel.backgroundSkin.alpha = 0;

			panel.paddingTop = 0;
			panel.paddingRight = this.smallGutterSize;
			panel.paddingBottom = this.smallGutterSize;
			panel.paddingLeft = this.smallGutterSize;

		}

		//-------------------------
		// PopUpManager
		//-------------------------

		//-------------------------
		// PickerList
		//-------------------------

		protected function setPickerListTransparentLightStyles( list:PickerList ):void {

			this.setPickerListTransparentBaseStyles( list );

		}

		protected function setPickerListTransparentBaseStyles( list:PickerList ):void {

			super.setPickerListStyles( list );

			// Default
			list.customButtonStyleName = FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_LIGHT_BUTTON;
			list.customListStyleName = FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_LIST;

			if ( list.popUpContentManager && ( list.popUpContentManager is CustomBottomDrawerPopUpManager )) {
				( list.popUpContentManager as CustomBottomDrawerPopUpManager ).openOrCloseDuration = .30;
				( list.popUpContentManager as CustomBottomDrawerPopUpManager ).customPanelStyleName =
					FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_POPUP_PANEL;
				( list.popUpContentManager as CustomBottomDrawerPopUpManager ).closeButtonLabel =
					FeathersExtLib_ThemeConstants.BOTTOM_PICKER_LIST_CLOSE_BUTTON_LABEL;
			}
		}

		protected function setPickerListTransparentDarkStyles( list:PickerList ):void {

			this.setPickerListTransparentBaseStyles( list );

			list.customButtonStyleName = FeathersExtLib_StyleNameConstants.PICKER_LIST__TRANSPARENT_DARK_BUTTON;

		}

		protected function setPickerListTransparentListStyles( list:List ):void {

			this.setScrollerStyles( list );

			var listSize:Number = roundToNearest( this.gridSize * 2 );
			var backgroundSkin:Quad = new Quad( listSize, listSize, LIST_BACKGROUND_COLOR );
			list.backgroundSkin = backgroundSkin;
		}

		protected function setPickerListTransparentPopUpPanelStyles( panel:Panel ):void {

			this.setScrollerStyles( panel );

			//panel.backgroundSkin = new Scale9Image( this.bg_popup, this.scale );
			panel.backgroundSkin = new Quad( 10, 10, 0x444444 );
			panel.backgroundSkin.alpha = 1;

			panel.paddingTop = 0;
			panel.paddingRight = 0; //this.smallGutterSize;
			panel.paddingBottom = 0; //this.smallGutterSize;
			panel.paddingLeft = 0; //this.smallGutterSize;

		}

		protected function setPickerListTransparentBaseButtonStyles( button:Button, labelFormat:ElementFormat = null,
																	 disabledLabelFormat:ElementFormat = null, icon:Texture = null,
																	 disabledIcon:Texture = null ):void {

			button.stateToSkinFunction = null;

			// Background
			var transQuad:Quad = new Quad( 10, 10, 0x000000 );
			transQuad.visible = false;
			button.defaultSkin = transQuad;

			this.setBaseButtonStyles( button );

			// Defaults
			if ( !labelFormat ) {
				labelFormat = this.lightUIElementFormat;
			}

			if ( !disabledLabelFormat ) {
				disabledLabelFormat = this.lightUIDisabledElementFormat;
			}

			if ( !icon ) {
				icon = this.pickerListButtonIconTexture;
			}

			if ( !disabledIcon ) {
				disabledIcon = this.pickerListButtonIconDisabledTexture;
			}

			// Font
			button.defaultLabelProperties.elementFormat = labelFormat;
			button.downLabelProperties.elementFormat = labelFormat;
			button.disabledLabelProperties.elementFormat = disabledLabelFormat;

			if ( button is ToggleButton ) {
				var toggleButton:ToggleButton = ToggleButton( button );
				toggleButton.defaultSelectedLabelProperties.elementFormat = labelFormat;
				toggleButton.selectedDisabledLabelProperties.elementFormat = disabledLabelFormat;
			}
			button.downLabelProperties.alpha = .6;
			button.defaultLabelProperties.alpha = 1;

			// Padding
			button.paddingTop = this.buttonPaddingTop;
			button.paddingBottom = this.buttonPaddingBottom;
			button.paddingLeft = this.buttonPaddingLeft;
			button.paddingRight = this.buttonPaddingRight;

			// Dimensions
			button.minWidth = 16 * fmgr.theme.scaledResolution; // button.minHeight = this.controlSize;
			button.iconOffsetY = -1 * fmgr.theme.scaledResolution;
			button.gap = Number.POSITIVE_INFINITY;
			button.minGap = this.gutterSize;

			// Icon
			var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.setValueTypeHandler( SubTexture, textureValueTypeHandler );
			iconSelector.defaultValue = icon;
			iconSelector.setValueForState( disabledIcon, Button.STATE_DISABLED, false );
			iconSelector.displayObjectProperties = { textureScale: this.contentScaleFactor, snapToPixels: true }

			button.stateToIconFunction = iconSelector.updateValue;
			button.iconPosition = Button.ICON_POSITION_RIGHT;
		}

		protected function setPickerListTransparentLightButtonStyles( button:Button ):void {

			this.setPickerListTransparentBaseButtonStyles( button, 
				this.lightFormTextElementFormat, 
				this.lightUIDisabledElementFormat );

		}

		protected function setPickerListTransparentDarkButtonStyles( button:Button ):void {

			this.setPickerListTransparentBaseButtonStyles( button,
														   this.darkFormTextElementFormat,
														   this.darkUIDisabledElementFormat,
														   this.pickerListButtonDarkIconTexture,
														   this.pickerListButtonDarkIconDisabledTexture );

		}
		
		
		//-------------------------
		// Text Input
		//-------------------------
		protected function setTextInputTransparentFormDarkStyles(input:TextInput):void{
			super.setTextInputTransparentStyles(input);	
			
			input.textEditorProperties.color = DARK_FORM_TEXT_COLOR;
			input.textEditorProperties.disabledColor = DARK_DISABLED_TEXT_COLOR;
			
			//input.promptProperties.alpha=.8;
			input.promptProperties.elementFormat = this.darkFormPromptElementFormat;
			input.promptProperties.disabledElementFormat = this.darkUIDisabledElementFormat;
		}
		
		protected function setTextInputTransparentFormLightStyles(input:TextInput):void{
			super.setTextInputTransparentStyles(input);	
			
			input.textEditorProperties.color = LIGHT_FORM_TEXT_COLOR;
			input.textEditorProperties.disabledColor = DISABLED_TEXT_COLOR;
			
			//input.promptProperties.alpha=.8;
			input.promptProperties.elementFormat = this.lightFormPromptElementFormat;
			input.promptProperties.disabledElementFormat = this.lightUIDisabledElementFormat;
		}
		

		//-------------------------
		// PickerList - DateTime
		//-------------------------
		
		protected function setPickerListDateTimeStyles(list:PickerList):void
		{
			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				list.popUpContentManager = new CalloutPopUpContentManager();
			}
			else
			{
				list.listFactory = pickerListDateTimeSpinnerListFactory;
				// Ahhender Changes: 
				list.popUpContentManager = new CustomBottomDrawerPopUpManager(); 
			}
			
			// Ahhender Changes: 
			list.resetObjectFunction = BaseFlatThemePoolFunctions.resetPickerListObject;
		}
		
		//-------------------------
		// PageIndicator
		//-------------------------

	/**
	 *
	 * @param pageIndicator
	 */
	/*protected function setPageIndicatorStyles( pageIndicator:PageIndicator ):void {

		pageIndicator.normalSymbolFactory = this.pageIndicatorNormalSymbolFactory;
		pageIndicator.selectedSymbolFactory = this.pageIndicatorSelectedSymbolFactory;
		pageIndicator.gap = this.smallGutterSize;
		pageIndicator.padding = this.smallGutterSize / 2;
		pageIndicator.minTouchWidth = this.smallControlSize * 2
		pageIndicator.minTouchHeight = this.smallControlSize * 2;
	}*/
	}
}
