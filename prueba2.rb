require 'net/http' 
require 'json'
require 'openssl'
require 'uri'

url = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&'
apikey = 'api_key=GPOt5KUVeNz9PPPwIPPx2uzVs6NLFWlIMbGgYNuA'

#agregar apikey
#concatenar la apikey en la url

def request(url,apikey)
    
    url = URI(url + apikey)
    http= Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)
    http.use_ssl=true
    #http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request=Net::HTTP::Get.new(url)
    request["cache-control"]="no-cache"
    request["postamn-token"]= '5f4b1b36-5bcd-4c49-f578-75a752af8fd5'
    response = http.request(request)
    return JSON.parse(response.read_body)

end

data = request(url,apikey)

#print data


data_photos = data["photos"]

def build_web_page(hash)

     html =""
    hash.each do |elem|
        html += "<li><img src=\"#{elem["img_src"]}\"></li>"
    end

    File.write("index.html",html)
end

 puts build_web_page(data_photos)

