namespace :indesign do
  erb_directory = Rails.root.join('lib','indesign')
  
  
  # getting indesign script directory, using wildcard '*/*' in case of different versions and languages
  indesign_script_directory = Dir[File.expand_path ("~/Library/Preferences/Adobe InDesign/*/*/Scripts/Scripts Panel")][0]
  
  
  namespace :erb do

    desc 'Create an erb scaffold for your iterator script for a  given model'
    task :scaffold, [:Model] => [:environment] do  |cmd,args|

      model_name = args[:Model].constantize
      model_iterator_erb_file_path = "#{erb_directory}/#{model_name.to_s.underscore}_iterator.js.erb"
      unless File.exists?(model_iterator_erb_file_path)
        
        iterator_erb_template_file_path = MyGem::Railtie.root.join('iterator.js.erb')
        scaffold = ERB.new(File.read(iterator_erb_template_file_path)).result(binding)

        FileUtils.mkdir_p File.dirname(model_iterator_erb_file_path)
        File.open(model_iterator_erb_file_path, 'w') { |f| f.write(scaffold) }
      else
        puts "Sorry, file #{model_iterator_erb_file_path} already exist, won't overwrite it, delete it manually"
      end

    end
    #    scaffold_file_path = Rails.root.join('lib','tasks','views','indesign','models',"#{model_name.to_s.tableize}_template.js")
  end

  namespace :script do

    #  require 'fileutils'
    # file_path = Rails.root.join('lib','tasks','views','indesign',"#{model_name}.js.erb")


    desc 'Create indesign .js script to create template for model, usefull to give to your graphic designer'
    task :template, [:Model] => [:environment] do  |cmd,args|

      model_name = args[:Model].constantize
      template_file_path = MyGem::Railtie.root.join('template.js.erb')
      template_script = ERB.new(File.read(template_file_path)).result(binding)
      template_script_file_path = File.expand_path "#{indesign_script_directory}/template_for_model_#{model_name.to_s.underscore}.js"

      # FileUtils.mkdir_p File.dirname(scaffold_file_path)
      p template_script_file_path
      File.open(template_script_file_path, 'w') { |f| f.write(template_script) }

    end

    desc 'Create indesign .js script to iterate over your recods, and for each record update the field, and export a pdf'
    task :iterator, [:Model] => [:environment] do |cmd,args|
      model_name = args[:Model].constantize
      iterator_erb_file_path = "#{erb_directory}/#{model_name.to_s.tableize}_iterator.js.erb"
      unless File.exists?(iterator_erb_file_path)
        puts "#{iterator_erb_file_path} does not exist, first create it with:\n\nrake indesign:erb:scaffold[#{args[:Model]}]\n"
      else

        model = model_name.find :all, :limit => 10
        iterator_script = ERB.new(File.read(iterator_erb_file_path)).result(binding)

        iterator_script_file_path = File.expand_path "#{indesign_script_directory}/iterator_for_model_#{model_name.to_s.underscore}.js"
        File.open(iterator_script_file_path, 'w') { |f| f.write(iterator_script) }


      end

    end

  end
end