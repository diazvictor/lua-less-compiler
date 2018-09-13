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
local main_window = ui.main_window
local about_window = ui.about_window

local menu_help_item1 = builder:get_object('menu_help_item1')
local menuitem1 = builder:get_object('menuitem1')

local inputFile = builder:get_object('inputFile')
local inputChoose = builder:get_object('inputChoose')

local outputFile = builder:get_object('outputFile')
local outputChoose = builder:get_object('outputChoose')

local inputEdit = builder:get_object('inputEdit')
local outputLog = builder:get_object('outputLog')

local textInfo = builder:get_object('textInfo')
textInfo.label = "File Standard: 188.9 KB | ".. os.date("%d-%m-%Y %H:%M:%S") .. " "

local setMinify = builder:get_object('setMinify')

local compile = builder:get_object('compile')

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

function inputFile:on_changed()
	inputChoose:set_filename(inputFile:get_text())
end

function outputFile:on_changed()
	outputChoose:set_filename(outputFile:get_text())
end

function inputChoose:on_file_set()
	inputFile:set_text(inputChoose:get_filename()):gsub(" ", "\\ ")
end

function outputChoose:on_file_set()
	outputFile:set_text(outputChoose:get_filename()):gsub(" ", "\\ ")
end

--------------------------------------------------------------------------------

function main_window:on_destroy()
	Gtk.main_quit()
end

main_window:show_all()
Gtk.main()
