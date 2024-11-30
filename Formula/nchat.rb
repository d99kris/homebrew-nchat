class Nchat < Formula
  desc "Terminal-based Telegram / WhatsApp client"
  homepage "https://github.com/d99kris/nchat"
  url "https://github.com/d99kris/nchat/archive/refs/tags/v5.3.5.tar.gz"
  sha256 "b9971a25e54805204ef6cf9c3f2be9a81fb987da57044ab6a599627e1f655417"
  license "MIT"

  option "without-whatsapp"
  option "without-telegram"

  depends_on "ccache"
  depends_on "cmake" => :build
  depends_on "go"
  depends_on "gperf"
  depends_on "help2man"
  depends_on "libmagic"
  depends_on "ncurses"
  depends_on "openssl"
  depends_on "readline"
  depends_on "sqlite"

  def install
    protocols = []
    if build.without? "telegram"
      protocols << "-DHAS_TELEGRAM=OFF"
    end
    if build.without? "whatsapp"
      protocols << "-DHAS_WHATSAPP=OFF"
    end
    mkdir "build" do
      system "cmake", "..", *protocols, *std_cmake_args
      system "make", "-s"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/nchat", "--version"
  end
end
