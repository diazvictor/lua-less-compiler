--[[--
 @package
 @filename  init.lua
 @version   1.0
 @author    Díaz Urbaneja Víctor Eduardo Diex <diaz.victor@openmailbox.org>
 @date      11.09.2018 23:36:32 -04
]]

require('lib.middleclass')

local lgi = require('lgi')

local GObject = lgi.GObject
local GLib = lgi.GLib
local Gtk = lgi.require('Gtk', '2.0')

local assert = lgi.assert
local builder = Gtk.Builder()

assert(builder:add_from_file('MainWindow.ui'), "Error el archivo no existe")

local ui = builder.objects

-- ui.textInfo.label = "File Standard: 188.9 KB | ".. os.date("%d-%m-%Y %H:%M:%S") .. " "

--------------------------------------------------------------------------------

function os.capture(cmd, raw)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()

	if raw then return s end
	s = string.gsub(s, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', ' ')
	return s
end

function file_exist(file)
	--return (io.open(file, "r") == nil) and false or true
	local file_found = io.open(file, "r")
	if (file_found == nil) then
		return false
	end
	return true
end

function ui.inputEdit:on_clicked()
	local _EDITOR = ""

	if (file_exist("/usr/bin/geany") == true) then
		_EDITOR = "geany"
	elseif (file_exist("/usr/bin/textadept") == true) then
		_EDITOR = "textadept"
	end

	os.capture(_EDITOR .. " " .. ui.inputFile.text)
end

function ui.inputFile:on_changed()
	ui.inputChoose:set_filename(ui.inputFile.text)
end

function ui.outputFile:on_changed()
	ui.outputChoose:set_filename(ui.outputFile.text)
end

function ui.inputChoose:on_file_set()
	ui.inputFile.text = (ui.inputChoose:get_filename()):gsub(" ", "\\ ")
end

function ui.outputChoose:on_file_set()
	ui.outputFile.text = (ui.outputChoose:get_filename()):gsub(" ", "\\ ")
end

function ui.compile:on_clicked()
	local cmd = 'lessc ' .. ui.inputFile.text .. ' > ' .. ui.outputFile.text

	if (ui.setMinify:get_active()) then
		cmd = 'lessc -x ' .. ui.inputFile.text .. ' > ' .. ui.outputFile.text
	end

	if (ui.inputFile.text ~= "" and ui.outputFile.text ~= "") then
		os.execute(cmd)
	end
end

--------------------------------------------------------------------------------

function ui.menu_help_item1:on_button_press_event()
	ui.about_window:run()
	ui.about_window:hide()
end

function ui.main_window:on_destroy()
	Gtk.main_quit()
end

ui.main_window:show_all()
Gtk.main()
