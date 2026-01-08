package app.organicmaps.notifications;

import android.content.Context;
import android.content.Intent;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;
import androidx.core.content.pm.LocusIdCompat;
import androidx.core.content.pm.ShortcutInfoCompat;
import androidx.core.content.pm.ShortcutManagerCompat;
import androidx.core.graphics.drawable.IconCompat;

import java.util.Collections;

import app.organicmaps.R;

public final class LiveUpdateHelper
{
  private static final int LIVE_UPDATES_API_LEVEL = 35; // Android 15

  private LiveUpdateHelper()
  {
  }

  public static boolean isLiveUpdatesApiAvailable()
  {
    return Build.VERSION.SDK_INT >= LIVE_UPDATES_API_LEVEL;
  }

  @NonNull
  public static NotificationCompat.Builder applyLiveUpdateMetadata(@NonNull Context context,
                                                                   @NonNull NotificationCompat.Builder builder,
                                                                   @NonNull String liveUpdateId,
                                                                   @NonNull Intent contentIntent,
                                                                   @NonNull CharSequence title,
                                                                   @Nullable CharSequence description)
  {
    if (!isLiveUpdatesApiAvailable())
      return builder;

    builder.setOnlyAlertOnce(true);

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S)
      builder.setForegroundServiceBehavior(NotificationCompat.FOREGROUND_SERVICE_IMMEDIATE);

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q)
      builder.setShortcutId(liveUpdateId);

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R)
      builder.setLocusId(new LocusIdCompat(liveUpdateId));

    final ShortcutInfoCompat shortcut = new ShortcutInfoCompat.Builder(context, liveUpdateId)
                                           .setShortLabel(title)
                                           .setLongLabel(description != null ? description : title)
                                           .setIcon(IconCompat.createWithResource(context, R.drawable.ic_logo_small))
                                           .setIntent(contentIntent)
                                           .setLocusId(new LocusIdCompat(liveUpdateId))
                                           .setCategories(Collections.singleton("app.organicmaps.liveupdate"))
                                           .build();
    ShortcutManagerCompat.pushDynamicShortcut(context, shortcut);
    return builder;
  }
}
