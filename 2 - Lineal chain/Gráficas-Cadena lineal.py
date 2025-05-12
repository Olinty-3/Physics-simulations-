#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Feb  3 13:53:33 2024

@author: isabe
"""

import pandas as pd 
import matplotlib.pyplot as plt 
import numpy as np

# Ejercicio 1 

data = '/Users/isabe/Desktop/Simulación /Proyecto 2/Cadena_lineal-Alfonso Marchante, Isabel/cadena_dos_masas.txt'

d = pd.read_csv(data)
d = d.to_numpy()

t = d[:,0]
E = d[:,1]

fig = plt.figure(figsize=(16, 16))

fig.suptitle('Dos masas')

ax1 = fig.add_subplot(221)
ax1.plot(t,E)
ax1.set_xlabel('t')
ax1.set_ylabel('(E-Eo)/Eo')

ax2 = fig.add_subplot(222)
ax2.plot(t,E)
ax2.set_xlabel('t')
ax2.set_ylabel('(E-Eo)/Eo')
ax2.set_ylim((-0.25,0.25))


# Ejercicio 2 

data2 = '/Users/isabe/Desktop/Simulación /Proyecto 2/Cadena_lineal-Alfonso Marchante, Isabel/cadena_ocho_masas.txt'

d2 = pd.read_csv(data2)
d2 = d2.to_numpy()

t2 = d2[:,0]
E2 = d2[:,1]

fig = plt.figure(figsize=(16, 16))

fig.suptitle('Ocho masas')

ax1 = fig.add_subplot(221)
ax1.plot(t2,E2)
ax1.set_xlabel('t')
ax1.set_ylabel('(E-Eo)/Eo')

ax2 = fig.add_subplot(222)
ax2.plot(t2,E2)
ax2.set_xlabel('t')
ax2.set_ylabel('(E-Eo)/Eo')
ax2.set_ylim((-0.25,0.25))

# Ejercicio 3 

x1 = d2[:,2]
x3 = d2[:,3]
x8 = d2[:,4]

fig = plt.figure(figsize=(16, 16))

ax1 = fig.add_subplot(111)
ax1.plot(t2,x1,label = 'x1')
ax1.plot(t2,x3,label = 'x3')
ax1.plot(t2,x8,label = 'x8')
ax1.set_xlabel('t')
ax1.legend()


# Ejercicio 4 

data3 = '/Users/isabe/Desktop/Simulación /Proyecto 2/Cadena_lineal-Alfonso Marchante, Isabel/TF_cadena_ocho_masas.txt'


d3 = pd.read_csv(data3)
d3 = d3.to_numpy()

Fw = d3[:,0]
w = d3[:,1]

fig = plt.figure(figsize=(16, 16))

ax1 = fig.add_subplot(221)
ax1.plot(w, Fw)
ax1.set_xlim((0,1.5))
ax1.set_xlabel('w')
ax1.set_ylabel('|F(w)|^2')

ax2 = fig.add_subplot(222)
ax2.plot(w, Fw)
ax2.set_yscale('log')
ax2.set_xlim((0,1.5))
ax2.set_xlabel('w')
ax2.set_ylabel('log(|F(w)|^2)')


#Ejercicio 5 

fig = plt.figure(figsize=(16, 16))

ax1 = fig.add_subplot(221)
ax1.plot(w, Fw)
ax1.set_xlim((0,1))
ax1.vlines(0.13,0,3*(10**6),colors=('red'))
ax1.vlines(0.246,0,3*(10**6),colors=('red'))
ax1.vlines(0.370,0,3*(10**6),colors=('red'))
ax1.vlines(0.476,0,3*(10**6),colors=('red'))
ax1.vlines(0.569,0,3*(10**6),colors=('red'))
ax1.vlines(0.666,0,3*(10**6),colors=('red'))
ax1.vlines(0.706,0,3*(10**6),colors=('red'))
ax1.vlines(0.767,0,3*(10**6),colors=('red'))
ax1.set_xlabel('w')
ax1.set_ylabel('|F(w)|^2')

ax2 = fig.add_subplot(222)
ax2.plot(w, Fw)
ax2.set_yscale('log')
ax2.set_xlim((0,1))
ax2.vlines(0.130,0,10**7,colors=('red'))
ax2.vlines(0.246,0,10**7,colors=('red'))
ax2.vlines(0.370,0,10**7,colors=('red'))
ax2.vlines(0.476,0,10**7,colors=('red'))
ax2.vlines(0.569,0,10**7,colors=('red'))
ax2.vlines(0.666,0,10**7,colors=('red'))
ax2.vlines(0.706,0,10**7,colors=('red'))
ax2.vlines(0.767,0,10**7,colors=('red'))
ax2.set_xlabel('w')
ax2.set_ylabel('log(|F(w)|^2)')
