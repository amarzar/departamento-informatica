#!/usr/bin/ruby
# encoding: utf-8
#
# $File: create-moodle-list.rb
#
# $Description:
#   A partir de un fichero CSV pasado por parámetro, con los datos
#   de los alumnos de informática (según lo genera el programa PinceEkade),
#   este script crea unos ficheros TXT por cada grupo para su carga en
#   Moodle.
#   Además cada fichero TXT servirá para que cada tutor comunique dichos
#   datos a sus alumnos de grupo.

require 'pry'

=begin
Formato de entrada:
  grupo, clave(dni), nombre, apellido1, apellido2, email

Formato de salida:
  username, password, firstname, lastname, email, city
  juanb, secreto, Juan, Benítez, janb@algo.edu, DAW
=end

class ListPeople
  SEPARATOR=","

  def initialize
    @debug=false
    @verbose=true
    @outputfilename='usuarios'
    @output={}

    @change=[ ['á','a'], ['é','e'], ['í','i'], ['ó','o'], ['ú','u'], ['Á','a'] , ['É','e'], ['Í','i'], ['Ó','o'], ['Ú','u'], ['Ñ','n'], ['ñ','n'], [' ',''] ]
  end

  def create_list_for(pArg)
    if pArg=='--help' then
      show_help
    else
      process(pArg)
    end
  end

  def process(filename)
    @filename = filename
    verbose "\n[INFO] Processing <#{@filename}>..."

    if !File.exists? @filename then
      puts "[ERROR] <#{@filename}> dosn't exist!\n"
      raise "[ERROR] <#{@filename}> dosn't exist!\n"
    end

    @file=File.open(@filename,'r')
    @data=@file.readlines

    @data.each do |line|
      items=line.split(SEPARATOR)
      raise "Error en los campos del CVS" if items.size<5

      grupo=items[0].downcase
      clave=items[1].downcase
      nombre=items[2].capitalize
      apellido1=items[3].capitalize
      apellido2=items[4].capitalize
      apellidos=apellido1+" "+apellido2
      email=items[5].gsub!("\n","").downcase

      #username
      u=nombre[0..2]+apellido1.gsub(' ','')[0..2]
      u=u+(apellido2.gsub(' ','')[0..2]||apellido1.gsub(' ','')[0..2])
      username=u.downcase
      @change.each { |i| username.gsub!(i[0],i[1]) }

      email="#{username}@cambiar-email.#{grupo}" if email.size<2
      clave="201617" if clave.size<2

      if @output[grupo.to_sym].nil? then
        f=File.open("#{@outputfilename}_#{grupo}.txt",'w')
        @output[grupo.to_sym]=f
        f.write("username;password;firstname;lastname;email;city\n")
      end
      #username, password, firstname, lastname, email, city
      msg = "#{username};#{clave};#{nombre};#{apellidos};#{email};#{grupo}"
      verbose( msg )
      @output[grupo.to_sym].write("#{msg}\n")
    end

    @file.close
    @output.each_value { |i| i.close }
  end

private

  def execute_command(lsCommand)
    verbose "(*) Executing: #{lsCommand}"
    system(lsCommand) if !@debug
  end

  def show_help
    puts "Uso:"
    puts " #{$0} FICHERO.csv"
    puts " "
    puts " Formato del fichero CSV:"
    puts "   grupo, clave/DNI, nombre, apellido1, apellido2, email"
  end

  def verbose(lsText)
    puts lsText if @verbose
  end
end

i = ListPeople.new
i.create_list_for (ARGV.first||'--help')

