class Ucon64 < Formula
  desc "ROM backup tool and emulator's Swiss Army knife program"
  homepage "http://ucon64.sourceforge.net/"
  url "https://downloads.sourceforge.net/ucon64/ucon64-2.0.0-src.tar.gz"
  sha256 "62064324a1912387f84ac9d4c521c5d5e7b80f2567e9f61bf0ab3e1d976c0127"

  resource "super_bat_puncher_demo" do
    url "http://morphcat.de/superbatpuncher/Super%20Bat%20Puncher%20Demo.zip"
    sha256 "d74cb3ba11a4ef5d0f8d224325958ca1203b0d8bb4a7a79867e412d987f0b846"
  end

  def install
    # ucon64's normal install process installs the discmage library in
    # the user's home folder. We want to store it inside the prefix, so
    # we have to change the default value of ~/.ucon64rc to point to it.
    # .ucon64rc is generated by the binary, so we adjust the default that
    # is set when no .ucon64rc exists.
    inreplace "src/ucon64_misc.c", "~/.ucon64/discmage.dylib",
                                   opt_prefix/"libexec/libdiscmage.dylib"

    cd "src" do
      system "./configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-silent-rules",
                            "--prefix=#{prefix}"
      system "make"
      bin.install "ucon64"
      libexec.install "libdiscmage/discmage.so" => "libdiscmage.dylib"
    end
  end

  def caveats; <<-EOS.undent
      You can copy/move your DAT file collection to $HOME/.ucon64/dat
      Be sure to check $HOME/.ucon64rc for configuration after running uCON64
      for the first time.
    EOS
  end

  test do
    resource("super_bat_puncher_demo").stage testpath

    assert_match "00000000  4e 45 53 1a  08 00 11 00  00 00 00 00  00 00 00 00",
                 shell_output("#{bin}/ucon64 \"#{testpath}/Super Bat Puncher Demo.nes\"")
  end
end
