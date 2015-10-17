require 'net/http'
require 'mandrill'
before do
      content_type :json
      headers 'Access-Control-Allow-Origin' => '*',
              'Access-Control-Allow-Methods' => ['POST']
end

    set :protection, false
    set :public_dir, Proc.new { File.join(root, "_site") }

post '/send_email' do
    m = Mandrill::API.new settings.api_key_mandrill
    template_name = settings.tag_mandrill
    template_content = [{
     :name => 'fullName',
     :content => params[:fullName]
    },{
     :name => 'email',
     :content => params[:email]
    },
    {
        :name => 'message',
        :content => params[:message]
    }]
      message = {"to"=>
        [{"email"=>settings.email_mandrill,
            "type"=>"to",
            "name"=>"Uracus"}],
     "subject"=>settings.subject_message_mandrill}
      resp=m.messages.send_template template_name, template_content, message
    puts resp
    if resp[0]['status'] == 'sent'
      { :message => 'success' }.to_json
    else
      { :message => 'failure_email' }.to_json
    end
end

not_found do
  { :message => 'inside not_found' }.to_json
end

get '/*' do
  file_name = "#{request.path_info}/index.html".gsub(%r{\/+},'/')
  if File.exists?(file_name)
    File.read(file_name)
  else
    raise Sinatra::NotFound
  end
end
