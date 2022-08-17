import os
import flag

import vtik

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application("VTik")
	fp.version("v0.0.1")
	fp.description("TikTok Downloader written in V (https://www.vlang.io)")
	fp.skip_executable()
	fp.limit_free_args_to_exactly(1)?
	fp.footer("The expected argument is the link of the video you want to download!")

	str_path := fp.string("output", `o`, os.getwd(), "The path where you want the video to be downloaded")

	add_args := fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		return
	}

	str_url := add_args[0]
	
	vt := vtik.new(str_url) or {
		eprintln(err)
		return
	}

	vt.download_video(str_path) or {
		eprintln(err)
		println("Couldn't download video")
		return
	}
}

