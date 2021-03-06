#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os,sys
from xml.etree import ElementTree
from PIL import Image


def print_texture(root):
    it = root.getiterator("SubTexture")
    for t in it:
        print t
        d = {}
        d['name'] = t.attrib['name']
        d['x'] = t.attrib['x']
        d['y'] = t.attrib['y']
        d['width'] = t.attrib['width']
        d['height'] = t.attrib['height']
        print d

def gen_png_from_plist(plist_filename, png_filename):
    print "gen png from plist " + plist_filename
    file_path = plist_filename.replace('.xml', '')
    print "out: " + file_path

    f = open(plist_filename, 'r')
    root = ElementTree.fromstring(f.read())
    f.close()
    it = root.getiterator("SubTexture")
    big_image = Image.open(png_filename)
    for t in it:
        name = t.attrib['name']
        x = int(t.attrib['x'])
        y = int(t.attrib['y'])
        w = int(t.attrib['width'])
        h = int(t.attrib['height'])
        if w<=0 or h <=0:
            continue
        rect_on_big = big_image.crop((x, y, x+w, y+h))
        result_image = Image.new('RGBA', (w, h), (0,0,0,0))
        result_image.paste(rect_on_big, (0, 0, w, h), mask=0)
        outfile = file_path+'/'+name+'.png'
        outDir = os.path.dirname(outfile)
        if not os.path.exists(outDir):
            os.makedirs(outDir)
        if os.path.exists(outfile):
            os.remove(outfile)
        print outfile, "generated"
        result_image.save(outfile)

if __name__ == '__main__':
    filename = sys.argv[1]
    plist_filename = filename + '.xml'
    png_filename = filename + '.png'
    if (os.path.exists(plist_filename) and os.path.exists(png_filename)):
        gen_png_from_plist(os.path.abspath(plist_filename), os.path.abspath(png_filename))
    else:
        print "make sure you have boith plist and png files in the same directory"
