package ${YYAndroidPackageName};
import java.lang.String;
import java.nio.ByteBuffer;
import android.app.Activity;

public final class GMDiscordSocial extends GMDiscordSocialInternal {
    
    public GMDiscordSocial() {
        Activity activity = RunnerActivity.CurrentActivity;
        com.discord.socialsdk.DiscordSocialSdkInit.setEngineActivity(activity);
    }

}