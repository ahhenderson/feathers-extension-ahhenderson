package feathers.extension.ahhenderson.mvc.actor {

	import ahhenderson.core.mvc.interfaces.ICommandActor;
	import ahhenderson.core.mvc.patterns.actor.CommandActor;
	import feathers.extension.ahhenderson.managers.FeathersApplicationManager;


	public class FeathersCommand extends CommandActor implements ICommandActor {
		public function FeathersCommand( name:String = null ) {

			super( name );
		}

		include "../../_includes/_FeathersAppManager.inc";

		override public function beforeRemove():void {

			super.beforeRemove();

			this.fmgr.logger.trace( this, "Command removed..." );

		}

		override public function onRegister():void {

			super.onRegister();

			this.fmgr.logger.trace( this, "Command registered..." );

		}
 
	}
}
