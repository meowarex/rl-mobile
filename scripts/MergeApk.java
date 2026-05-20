import java.io.*;
import java.util.*;
import java.util.zip.*;

// Merges an APKMirror split-APK bundle into a single installable APK.
// Usage: java MergeApk out.apk base.apk split1.apk split2.apk ...
public class MergeApk {
    public static void main(String[] args) throws Exception {
        if (args.length < 2) {
            System.err.println("Usage: java MergeApk out.apk base.apk [split.apk ...]");
            System.exit(1);
        }
        String out = args[0];
        Set<String> seen = new HashSet<>();
        try (ZipOutputStream zos = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(out)))) {
            for (int i = 1; i < args.length; i++) {
                String src = args[i];
                boolean isBase = i == 1;
                int added = 0, skipped = 0;
                try (ZipFile zip = new ZipFile(src)) {
                    Enumeration<? extends ZipEntry> entries = zip.entries();
                    while (entries.hasMoreElements()) {
                        ZipEntry e = entries.nextElement();
                        if (e.isDirectory()) { skipped++; continue; }
                        String name = e.getName();
                        if (!isBase && (
                                name.equals("AndroidManifest.xml") ||
                                name.equals("resources.arsc") ||
                                name.startsWith("META-INF/") ||
                                name.equals("stamp-cert-sha256"))) {
                            skipped++;
                            continue;
                        }
                        if (seen.contains(name)) { skipped++; continue; }
                        seen.add(name);

                        ZipEntry ne = new ZipEntry(name);
                        if (e.getMethod() == ZipEntry.STORED) {
                            ne.setMethod(ZipEntry.STORED);
                            ne.setSize(e.getSize());
                            ne.setCompressedSize(e.getSize());
                            ne.setCrc(e.getCrc());
                        } else {
                            ne.setMethod(ZipEntry.DEFLATED);
                        }
                        zos.putNextEntry(ne);
                        try (InputStream is = zip.getInputStream(e)) {
                            byte[] buf = new byte[16384];
                            int n;
                            while ((n = is.read(buf)) > 0) zos.write(buf, 0, n);
                        }
                        zos.closeEntry();
                        added++;
                    }
                }
                System.out.printf("%s: +%d added, %d skipped%n", src, added, skipped);
            }
        }
        System.out.printf("Wrote %d entries to %s%n", seen.size(), out);
    }
}
