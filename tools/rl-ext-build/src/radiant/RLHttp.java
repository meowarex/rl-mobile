package radiant;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

// HTTP for flush and Sylla, we need the status code
public final class RLHttp {
    // 0 means network error or timeout
    public int status;
    public String body;
    public String error;

    private RLHttp() {}

    static RLHttp request(String method, String url, String json, int readTimeoutMs) {
        RLHttp r = new RLHttp();
        HttpURLConnection c = null;
        try {
            c = (HttpURLConnection) new URL(url).openConnection();
            c.setRequestMethod(method);
            c.setConnectTimeout(10000);
            c.setReadTimeout(readTimeoutMs);
            c.setRequestProperty("P-Access-Token-Id", "58hy4s86");
            c.setRequestProperty("P-Access-Token", "xjehy2lfg5h5mjwotoxrcqugam");
            c.setRequestProperty("x-client-ip", RLAPILyricsWorker.clientIp());
            if (json != null) {
                c.setDoOutput(true);
                c.setRequestProperty("content-type", "application/json");
                OutputStream os = c.getOutputStream();
                os.write(json.getBytes("UTF-8"));
                os.close();
            }
            r.status = c.getResponseCode();
            InputStream in = r.status >= 400 ? c.getErrorStream() : c.getInputStream();
            r.body = in == null ? "" : read(in);
            RLAPILyricsHook.dlog(method + " status=" + r.status + " url=" + url);
        } catch (java.net.SocketTimeoutException e) {
            r.status = 0;
            r.error = "timed out";
            RLAPILyricsHook.dlog(method + " timed out url=" + url);
        } catch (Throwable t) {
            r.status = 0;
            r.error = String.valueOf(t);
            RLAPILyricsHook.dlog(method + " error url=" + url + " err=" + t);
        } finally {
            if (c != null) c.disconnect();
        }
        return r;
    }

    boolean ok() {
        return status >= 200 && status < 300;
    }

    private static String read(InputStream in) throws java.io.IOException {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        byte[] buf = new byte[8192];
        int n;
        while ((n = in.read(buf)) > 0) out.write(buf, 0, n);
        in.close();
        return out.toString("UTF-8");
    }
}
