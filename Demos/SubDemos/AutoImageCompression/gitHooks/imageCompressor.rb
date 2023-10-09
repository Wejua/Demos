require "tinify"
# 李帅帅：L1DfbF8kpRzstlMfbvmkvCSg6knkQD71
# 赵扬扬：B83mGyQcbpmFzz1Qym5ZdhT3Ss503b5b
# 周位杰：tbfVHxRmxxR3Vb3XQwrxMbfHPNnxszpH
# 刘亚飞：2L6km1p5yJRZsNYs0GJ6m4klL1rMJ4RJ
# 游古丽：5wmc8dDxY1WKg4DTPSLXQ20dWWjRbzyG
# 王易阳：1DkYWCXDvPJfMrNbV6NPB0QpQTGzZLfD
# 吴亚楠：bRG9yXbc07w77sP43gqjgP8tlgDPjdVJ
# 张锐杰：xwvXrTp2pSJYWDjkHQ7wTBTxDMbLdx4r
# 唐绍禹：4pFYmxVBK6vnpKR5hh8r0hD4BGmS75K4
# 王少宁：6rSpQHxHpygLyZMQnTH6WNjxGVV9mt0x

$keys = %w[tbfVHxRmxxR3Vb3XQwrxMbfHPNnxszpH B83mGyQcbpmFzz1Qym5ZdhT3Ss503b5b L1DfbF8kpRzstlMfbvmkvCSg6knkQD71 2L6km1p5yJRZsNYs0GJ6m4klL1rMJ4RJ 5wmc8dDxY1WKg4DTPSLXQ20dWWjRbzyG 1DkYWCXDvPJfMrNbV6NPB0QpQTGzZLfD bRG9yXbc07w77sP43gqjgP8tlgDPjdVJ xwvXrTp2pSJYWDjkHQ7wTBTxDMbLdx4r 4pFYmxVBK6vnpKR5hh8r0hD4BGmS75K4 6rSpQHxHpygLyZMQnTH6WNjxGVV9mt0x]
$keys_index = -1
$image_path = ARGV[0]
$branch_name = ARGV[1]
# 获取.git所在目录
git_path = `git rev-parse --git-dir`; git_path = git_path.strip;
# 获取当前文件所在目录
cur_path = `printf $(cd '#{git_path}'; cd ..; pwd)/gitHooks`; cur_path = cur_path.strip;
$white_list_path = "#{cur_path}/imageCompressWhiteList.txt"
def setup_key
    $keys_index += 1
    Tinify.key = $keys[$keys_index]
    Tinify.validate! # validate后会更新compression_count
    if $keys_index == $keys.length
        puts "本月所有免费使用次数都用完，请增加key"
    elsif Tinify.compression_count >= 500
        setup_key
    end
end

def ignore?
    file = File.new($white_list_path, "a+")
    file.readlines.each { |line|
        line_without_white_space = line.strip
        if line_without_white_space.length > 0
            result = $image_path.match?(line_without_white_space)
            if result
                return true
            end
        end
    }
    return false
end

begin
    # Use the Tinify API client.
    result = ignore?
    if result
        puts "图片在白名单中，不压缩：" + $image_path
    else
        setup_key
        Tinify.from_file($image_path).to_file($image_path)
        puts "图片压缩成功：" + $image_path
    end
rescue Tinify::AccountError
    # Verify your API key and account limit.
    setup_key
rescue Tinify::ClientError => e
    # Check your source image and request options.
    puts "图片压缩失败：" + $image_path + ", ClientError：#{e.message}"
rescue Tinify::ServerError => e
    # Temporary issue with the Tinify API.
    puts "图片压缩失败：" + $image_path + ", ServerError：#{e.message}"
rescue Tinify::ConnectionError => e
    # A network connection error occurred.
    puts "图片压缩失败：" + $image_path + ", ConnectionError：#{e.message}"
rescue => e
    # Something else went wrong, unrelated to the Tinify API.
    puts "图片压缩失败：" + $image_path + ", OtherError：#{e.message}"
end
