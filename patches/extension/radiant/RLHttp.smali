.class public final Lradiant/RLHttp;
.super Ljava/lang/Object;


# instance fields
.field public body:Ljava/lang/String;

.field public error:Ljava/lang/String;

.field public status:I


# direct methods
.method private constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static read(Ljava/io/InputStream;)Ljava/lang/String;
    .registers 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    const/16 v1, 0x2000

    new-array v1, v1, [B

    :goto_9
    invoke-virtual {p0, v1}, Ljava/io/InputStream;->read([B)I

    move-result v2

    if-lez v2, :cond_14

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_9

    :cond_14
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V

    const-string p0, "UTF-8"

    invoke-virtual {v0, p0}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static request(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Lradiant/RLHttp;
    .registers 8

    new-instance v0, Lradiant/RLHttp;

    invoke-direct {v0}, Lradiant/RLHttp;-><init>()V

    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_7
    new-instance v3, Ljava/net/URL;

    invoke-direct {v3, p1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v3

    check-cast v3, Ljava/net/HttpURLConnection;
    :try_end_12
    .catch Ljava/net/SocketTimeoutException; {:try_start_7 .. :try_end_12} :catch_d3
    .catchall {:try_start_7 .. :try_end_12} :catchall_a3

    :try_start_12
    invoke-virtual {v3, p0}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    const/16 v2, 0x2710

    invoke-virtual {v3, v2}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    invoke-virtual {v3, p3}, Ljava/net/HttpURLConnection;->setReadTimeout(I)V

    const-string p3, "P-Access-Token-Id"

    const-string v2, "__RL_ACCESS_TOKEN_ID__"

    invoke-virtual {v3, p3, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    const-string p3, "P-Access-Token"

    const-string v2, "__RL_ACCESS_TOKEN__"

    invoke-virtual {v3, p3, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    const-string p3, "x-client-ip"

    invoke-static {}, Lradiant/RLAPILyricsWorker;->clientIp()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, p3, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    if-eqz p2, :cond_51

    const/4 p3, 0x1

    invoke-virtual {v3, p3}, Ljava/net/HttpURLConnection;->setDoOutput(Z)V

    const-string p3, "content-type"

    const-string v2, "application/json"

    invoke-virtual {v3, p3, v2}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getOutputStream()Ljava/io/OutputStream;

    move-result-object p3

    const-string v2, "UTF-8"

    invoke-virtual {p2, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p2

    invoke-virtual {p3, p2}, Ljava/io/OutputStream;->write([B)V

    invoke-virtual {p3}, Ljava/io/OutputStream;->close()V

    :cond_51
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result p2

    iput p2, v0, Lradiant/RLHttp;->status:I

    iget p2, v0, Lradiant/RLHttp;->status:I

    const/16 p3, 0x190

    if-lt p2, p3, :cond_62

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getErrorStream()Ljava/io/InputStream;

    move-result-object p2

    goto :goto_66

    :cond_62
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object p2

    :goto_66
    if-nez p2, :cond_6b

    const-string p2, ""

    goto :goto_6f

    :cond_6b
    invoke-static {p2}, Lradiant/RLHttp;->read(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object p2

    :goto_6f
    iput-object p2, v0, Lradiant/RLHttp;->body:Ljava/lang/String;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p3, " status="

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    iget p3, v0, Lradiant/RLHttp;->status:I

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string p3, " url="

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V
    :try_end_97
    .catch Ljava/net/SocketTimeoutException; {:try_start_12 .. :try_end_97} :catch_a0
    .catchall {:try_start_12 .. :try_end_97} :catchall_9d

    if-eqz v3, :cond_f9

    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->disconnect()V

    goto :goto_f9

    :catchall_9d
    move-exception p2

    move-object v2, v3

    goto :goto_a4

    :catch_a0
    move-exception p2

    move-object v2, v3

    goto :goto_d4

    :catchall_a3
    move-exception p2

    :goto_a4
    :try_start_a4
    iput v1, v0, Lradiant/RLHttp;->status:I

    invoke-static {p2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p3

    iput-object p3, v0, Lradiant/RLHttp;->error:Ljava/lang/String;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p3, " error url="

    invoke-virtual {p0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " err="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V

    if-eqz v2, :cond_f9

    goto :goto_f6

    :catch_d3
    move-exception p2

    :goto_d4
    iput v1, v0, Lradiant/RLHttp;->status:I

    const-string p2, "timed out"

    iput-object p2, v0, Lradiant/RLHttp;->error:Ljava/lang/String;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p2, " timed out url="

    invoke-virtual {p0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lradiant/RLAPILyricsHook;->dlog(Ljava/lang/String;)V
    :try_end_f4
    .catchall {:try_start_a4 .. :try_end_f4} :catchall_fa

    if-eqz v2, :cond_f9

    :goto_f6
    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_f9
    :goto_f9
    return-object v0

    :catchall_fa
    move-exception p0

    if-eqz v2, :cond_100

    invoke-virtual {v2}, Ljava/net/HttpURLConnection;->disconnect()V

    :cond_100
    throw p0
.end method


# virtual methods
.method ok()Z
    .registers 3

    iget v0, p0, Lradiant/RLHttp;->status:I

    const/16 v1, 0xc8

    if-lt v0, v1, :cond_e

    iget v0, p0, Lradiant/RLHttp;->status:I

    const/16 v1, 0x12c

    if-ge v0, v1, :cond_e

    const/4 v0, 0x1

    goto :goto_f

    :cond_e
    const/4 v0, 0x0

    :goto_f
    return v0
.end method
