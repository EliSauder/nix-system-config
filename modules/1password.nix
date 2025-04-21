{config,pkgs,options,lib,...}: 
let
    cfg = config.prog.onepassword;
in {
    options.prog =  {
        onepassword.enable = lib.mkEnableOption "Enable 1password";
    };

    config = lib.mkIf cfg.enable {
    } // lib.optionalAttrs ((options?programs._1password)) {
        programs._1password.enable = true;
    } // lib.optionalAttrs ((options?programs._1password-gui)) {
        programs._1password-gui = {
        	enable = true;
    	# TODO: Update to be more dynamic and not require the hardcoding of user names
    	    polkitPolicyOwners = [
    	        "esauder"
    	    ];
        };
    };
}
