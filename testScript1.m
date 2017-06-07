clear all; close all; clc;

originalImg = im2double(imread('sample1.jpg'));
imageRectification(originalImg, 450, 600);