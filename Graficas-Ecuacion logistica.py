#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jan 26 18:00:30 2024

@author: isabe
"""

import pandas as pd 
import matplotlib.pyplot as plt 
import numpy as np

# Ejercicio 1

data = '/Users/isabe/Desktop/Simulación /Proyecto 1 /caos-diagrama-de-Feigerbrau-iam.txt'

x = pd.read_csv(data)
x = x.to_numpy()

r = x[:,0]
xf = x[:,1]

fig = plt.figure(figsize=(16, 16))

ax1 = fig.add_subplot(111)
ax1.plot(r , xf , '.' , ms =0.02)
ax1.set_title("Diagrama de Feigenbaum")
ax1.set_xlabel('r')
ax1.set_ylabel('x_final')

# Ejercicio 2 

fig = plt.figure(figsize=(16, 16))

ax1 = fig.add_subplot(221)
ax1.plot(r , xf , '.' , ms =0.02)
ax1.set_xlabel('r')
ax1.set_ylabel('x_final')
ax1.set_xlim((0.6,1))
ax1.set_ylim((0.7,1))

ax2 = fig.add_subplot(222)
ax2.plot(r , xf , '.' , ms =0.02)
ax2.set_xlabel('r')
ax2.set_ylabel('x_final')
ax2.set_xlim((0.8,1))
ax2.set_ylim((0.85,1))

# Ejercicio 4 - comprobación 

fig = plt.figure(figsize=(16, 16))

ax1 = fig.add_subplot(111)
ax1.plot(r , xf , '.' , ms =0.05)
ax1.set_title("Comprobación segundo numero de Feigenbaum")
ax1.set_xlabel('r')
ax1.set_ylabel('x_final')
ax1.hlines(0.5, 0, 1 , colors=('black') , label = 'x = 0.5' )
ax1.vlines(0.809, 0.5, 0.811 , colors=('red') , label = 'r1 = 0.8090')
ax1.vlines(0.8746, 0.5, 0.3844 , colors=('red') , label = 'r2 = 0.8746')
ax1.vlines(0.8886, 0.5, 0.5474 , colors=('red') , label = 'r3 = 0.8886')
ax1.set_xlim((0.75, 1))
ax1.legend()
ax1.text(0.813 , 0.655 , 'd1 = 0.3090')
ax1.text(0.879 , 0.439 , 'd2 = 0.1162')
ax1.text(0.891 , 0.521 , 'd3 = 0.0454')

