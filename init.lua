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
textInfo.label = ""

local setMinify = builder:get_object('setMinify')

local compile = builder:get_object('compile')

--------------------------------------------------------------------------------

--------------------------------------------------------------------------------

function main_window:on_destroy()
	Gtk.main_quit()
end

main_window:show_all()
Gtk.main()
