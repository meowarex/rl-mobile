package com.meowarex.rlmobile.pebble

import android.os.SystemClock
import io.rebble.pebblekit2.client.BasePebbleListenerService
import io.rebble.pebblekit2.common.model.PebbleDictionary
import io.rebble.pebblekit2.common.model.ReceiveResult
import io.rebble.pebblekit2.common.model.WatchIdentifier
import java.util.UUID

// Forwards watch events to the relay
class PebbleWatchListenerService : BasePebbleListenerService() {
    override suspend fun onMessageReceived(
        watchappUUID: UUID,
        data: PebbleDictionary,
        watch: WatchIdentifier,
    ): ReceiveResult {
        val receivedAt = SystemClock.elapsedRealtime()
        if (watchappUUID != WatchProtocol.APP_UUID) return ReceiveResult.Nack
        PebbleRelayService.current?.onWatchMessage(WatchProtocol.ints(data), receivedAt)
        return ReceiveResult.Ack
    }

    override fun onAppOpened(watchappUUID: UUID, watch: WatchIdentifier) {
        if (watchappUUID != WatchProtocol.APP_UUID) return
        watchappOpen = true
        PebbleRelayService.current?.onWatchappOpened()
    }

    override fun onAppClosed(watchappUUID: UUID, watch: WatchIdentifier) {
        if (watchappUUID != WatchProtocol.APP_UUID) return
        watchappOpen = false
        PebbleRelayService.current?.onWatchappClosed()
    }

    companion object {
        @Volatile
        var watchappOpen = false
            private set
    }
}
