clear all; close all; clc;

originalImg = im2double(imread('sample.jpg'));
imageRectification(originalImg, 450, 600);