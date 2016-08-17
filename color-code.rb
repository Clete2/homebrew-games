class ColorCode < Formula
  desc "Free advanced MasterMind clone"
  homepage "http://colorcode.laebisch.com/"
  url "http://colorcode.laebisch.com/download/ColorCode-0.8.5.tar.gz"
  sha256 "7c128db12af6ab11439eb710091b4a448100553a4d11d3a7c8dafdfbc57c1a85"

  bottle do
    cellar :any
    sha256 "4385158349a2eeb7503fc3b7a6a97d3f9235a3686eaf9a0c2f251efa6ff1bec0" => :el_capitan
    sha256 "c5bf7b180d9a6fbf4e0564647e640eaa62e91969ce24684ce6f650d60dde0074" => :yosemite
    sha256 "d82d9e6fef4c86b55f13dc681b9fd117a86d4885b79e43960b2cbb28cec168aa" => :mavericks
  end

  depends_on "qt5"

  def install
    system "qmake"
    system "make"
    prefix.install "ColorCode.app"
    bin.write_exec_script "#{prefix}/ColorCode.app/Contents/MacOS/colorcode"
  end

  test do
    system "#{bin}/colorcode", "-h"
  end
end
