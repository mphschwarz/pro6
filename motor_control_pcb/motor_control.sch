EESchema Schematic File Version 4
LIBS:motor_control-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CmpCst:MAX1000 U0
U 1 1 5CBDB71A
P 1550 1050
F 0 "U0" H 2000 1237 60  0000 C CNN
F 1 "MAX1000" H 2000 1131 60  0000 C CNN
F 2 "CmpCst:MAX1000" H 1750 1550 60  0001 C CNN
F 3 "" H 1750 1550 60  0000 C CNN
	1    1550 1050
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:SN74LV1T126 U1
U 1 1 5CBDB7B9
P 4650 1200
F 0 "U1" H 4900 1387 60  0000 C CNN
F 1 "SN74LV1T126" H 4900 1281 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 4850 1700 60  0001 C CNN
F 3 "" H 4850 1700 60  0000 C CNN
	1    4650 1200
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:SN74LV1T126 U2
U 1 1 5CBDBB2E
P 4650 2000
F 0 "U2" H 4900 2187 60  0000 C CNN
F 1 "SN74LV1T126" H 4900 2081 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 4850 2500 60  0001 C CNN
F 3 "" H 4850 2500 60  0000 C CNN
	1    4650 2000
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:SN74LV1T126 U3
U 1 1 5CBDBBA5
P 4650 2800
F 0 "U3" H 4900 2987 60  0000 C CNN
F 1 "SN74LV1T126" H 4900 2881 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 4850 3300 60  0001 C CNN
F 3 "" H 4850 3300 60  0000 C CNN
	1    4650 2800
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+5V #PWR0101
U 1 1 5CBDC238
P 4350 1300
F 0 "#PWR0101" H 4350 1150 50  0001 C CNN
F 1 "+5V" H 4365 1473 50  0000 C CNN
F 2 "" H 4350 1300 60  0000 C CNN
F 3 "" H 4350 1300 60  0000 C CNN
	1    4350 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 1300 4450 1300
Wire Wire Line
	4450 1400 4350 1400
Wire Wire Line
	4350 1400 4350 1300
Connection ~ 4350 1300
$Comp
L CmpCst:GND #PWR0102
U 1 1 5CBDC300
P 4350 1600
F 0 "#PWR0102" H 4350 1350 50  0001 C CNN
F 1 "GND" H 4355 1477 50  0000 C CNN
F 2 "" H 4350 1600 60  0000 C CNN
F 3 "" H 4350 1600 60  0000 C CNN
	1    4350 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 1600 4450 1600
Text GLabel 4450 1500 0    50   Input ~ 0
B6_1_high_3.3
Text GLabel 4450 2300 0    50   Input ~ 0
B6_1_low_3.3
Text GLabel 4450 3100 0    50   Input ~ 0
B6_1_enable_3.3
Text GLabel 5350 1500 2    50   Input ~ 0
B6_1_high_5
Text GLabel 5350 2300 2    50   Input ~ 0
B6_1_low_5
Text GLabel 5350 3100 2    50   Input ~ 0
B6_1_enable_5
$Comp
L CmpCst:+5V #PWR0103
U 1 1 5CBDC62D
P 4350 2100
F 0 "#PWR0103" H 4350 1950 50  0001 C CNN
F 1 "+5V" H 4365 2273 50  0000 C CNN
F 2 "" H 4350 2100 60  0000 C CNN
F 3 "" H 4350 2100 60  0000 C CNN
	1    4350 2100
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+5V #PWR0104
U 1 1 5CBDC640
P 4350 2900
F 0 "#PWR0104" H 4350 2750 50  0001 C CNN
F 1 "+5V" H 4365 3073 50  0000 C CNN
F 2 "" H 4350 2900 60  0000 C CNN
F 3 "" H 4350 2900 60  0000 C CNN
	1    4350 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 2900 4450 2900
Wire Wire Line
	4450 3000 4350 3000
Wire Wire Line
	4350 3000 4350 2900
Connection ~ 4350 2900
Wire Wire Line
	4350 2100 4450 2100
Wire Wire Line
	4450 2200 4350 2200
Wire Wire Line
	4350 2200 4350 2100
Connection ~ 4350 2100
$Comp
L CmpCst:GND #PWR0105
U 1 1 5CBDC773
P 4350 2400
F 0 "#PWR0105" H 4350 2150 50  0001 C CNN
F 1 "GND" H 4355 2277 50  0000 C CNN
F 2 "" H 4350 2400 60  0000 C CNN
F 3 "" H 4350 2400 60  0000 C CNN
	1    4350 2400
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:GND #PWR0106
U 1 1 5CBDC786
P 4350 3200
F 0 "#PWR0106" H 4350 2950 50  0001 C CNN
F 1 "GND" H 4355 3077 50  0000 C CNN
F 2 "" H 4350 3200 60  0000 C CNN
F 3 "" H 4350 3200 60  0000 C CNN
	1    4350 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 3200 4450 3200
Wire Wire Line
	4450 2400 4350 2400
Text GLabel 1350 1950 0    50   Input ~ 0
B6_1_high_3.3
Text GLabel 1350 2050 0    50   Input ~ 0
B6_1_low_3.3
Text GLabel 1350 2150 0    50   Input ~ 0
B6_1_enable_3.3
$Comp
L CmpCst:SN74LV1T126 U4
U 1 1 5CBDCD73
P 6950 1200
F 0 "U4" H 7200 1387 60  0000 C CNN
F 1 "SN74LV1T126" H 7200 1281 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 7150 1700 60  0001 C CNN
F 3 "" H 7150 1700 60  0000 C CNN
	1    6950 1200
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:SN74LV1T126 U5
U 1 1 5CBDCD7A
P 6950 2000
F 0 "U5" H 7200 2187 60  0000 C CNN
F 1 "SN74LV1T126" H 7200 2081 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 7150 2500 60  0001 C CNN
F 3 "" H 7150 2500 60  0000 C CNN
	1    6950 2000
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:SN74LV1T126 U6
U 1 1 5CBDCD81
P 6950 2800
F 0 "U6" H 7200 2987 60  0000 C CNN
F 1 "SN74LV1T126" H 7200 2881 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 7150 3300 60  0001 C CNN
F 3 "" H 7150 3300 60  0000 C CNN
	1    6950 2800
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+5V #PWR0107
U 1 1 5CBDCD88
P 6650 1300
F 0 "#PWR0107" H 6650 1150 50  0001 C CNN
F 1 "+5V" H 6665 1473 50  0000 C CNN
F 2 "" H 6650 1300 60  0000 C CNN
F 3 "" H 6650 1300 60  0000 C CNN
	1    6650 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 1300 6750 1300
Wire Wire Line
	6750 1400 6650 1400
Wire Wire Line
	6650 1400 6650 1300
Connection ~ 6650 1300
$Comp
L CmpCst:GND #PWR0108
U 1 1 5CBDCD92
P 6650 1600
F 0 "#PWR0108" H 6650 1350 50  0001 C CNN
F 1 "GND" H 6655 1477 50  0000 C CNN
F 2 "" H 6650 1600 60  0000 C CNN
F 3 "" H 6650 1600 60  0000 C CNN
	1    6650 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 1600 6750 1600
Text GLabel 6750 1500 0    50   Input ~ 0
B6_2_high_3.3
Text GLabel 6750 2300 0    50   Input ~ 0
B6_2_low_3.3
Text GLabel 6750 3100 0    50   Input ~ 0
B6_2_enable_3.3
Text GLabel 7650 1500 2    50   Input ~ 0
B6_2_high_5
Text GLabel 7650 2300 2    50   Input ~ 0
B6_2_low_5
Text GLabel 7650 3100 2    50   Input ~ 0
B6_2_enable_5
$Comp
L CmpCst:+5V #PWR0109
U 1 1 5CBDCD9F
P 6650 2100
F 0 "#PWR0109" H 6650 1950 50  0001 C CNN
F 1 "+5V" H 6665 2273 50  0000 C CNN
F 2 "" H 6650 2100 60  0000 C CNN
F 3 "" H 6650 2100 60  0000 C CNN
	1    6650 2100
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+5V #PWR0110
U 1 1 5CBDCDA5
P 6650 2900
F 0 "#PWR0110" H 6650 2750 50  0001 C CNN
F 1 "+5V" H 6665 3073 50  0000 C CNN
F 2 "" H 6650 2900 60  0000 C CNN
F 3 "" H 6650 2900 60  0000 C CNN
	1    6650 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 2900 6750 2900
Wire Wire Line
	6750 3000 6650 3000
Wire Wire Line
	6650 3000 6650 2900
Connection ~ 6650 2900
Wire Wire Line
	6650 2100 6750 2100
Wire Wire Line
	6750 2200 6650 2200
Wire Wire Line
	6650 2200 6650 2100
Connection ~ 6650 2100
$Comp
L CmpCst:GND #PWR0111
U 1 1 5CBDCDB3
P 6650 2400
F 0 "#PWR0111" H 6650 2150 50  0001 C CNN
F 1 "GND" H 6655 2277 50  0000 C CNN
F 2 "" H 6650 2400 60  0000 C CNN
F 3 "" H 6650 2400 60  0000 C CNN
	1    6650 2400
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:GND #PWR0112
U 1 1 5CBDCDB9
P 6650 3200
F 0 "#PWR0112" H 6650 2950 50  0001 C CNN
F 1 "GND" H 6655 3077 50  0000 C CNN
F 2 "" H 6650 3200 60  0000 C CNN
F 3 "" H 6650 3200 60  0000 C CNN
	1    6650 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6650 3200 6750 3200
Wire Wire Line
	6750 2400 6650 2400
$Comp
L CmpCst:SN74LV1T126 U7
U 1 1 5CBDE827
P 9300 1200
F 0 "U7" H 9550 1387 60  0000 C CNN
F 1 "SN74LV1T126" H 9550 1281 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 9500 1700 60  0001 C CNN
F 3 "" H 9500 1700 60  0000 C CNN
	1    9300 1200
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:SN74LV1T126 U8
U 1 1 5CBDE82E
P 9300 2000
F 0 "U8" H 9550 2187 60  0000 C CNN
F 1 "SN74LV1T126" H 9550 2081 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 9500 2500 60  0001 C CNN
F 3 "" H 9500 2500 60  0000 C CNN
	1    9300 2000
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:SN74LV1T126 U9
U 1 1 5CBDE835
P 9300 2800
F 0 "U9" H 9550 2987 60  0000 C CNN
F 1 "SN74LV1T126" H 9550 2881 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 9500 3300 60  0001 C CNN
F 3 "" H 9500 3300 60  0000 C CNN
	1    9300 2800
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+5V #PWR0113
U 1 1 5CBDE83C
P 9000 1300
F 0 "#PWR0113" H 9000 1150 50  0001 C CNN
F 1 "+5V" H 9015 1473 50  0000 C CNN
F 2 "" H 9000 1300 60  0000 C CNN
F 3 "" H 9000 1300 60  0000 C CNN
	1    9000 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 1300 9100 1300
Wire Wire Line
	9100 1400 9000 1400
Wire Wire Line
	9000 1400 9000 1300
Connection ~ 9000 1300
$Comp
L CmpCst:GND #PWR0114
U 1 1 5CBDE846
P 9000 1600
F 0 "#PWR0114" H 9000 1350 50  0001 C CNN
F 1 "GND" H 9005 1477 50  0000 C CNN
F 2 "" H 9000 1600 60  0000 C CNN
F 3 "" H 9000 1600 60  0000 C CNN
	1    9000 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 1600 9100 1600
Text GLabel 9100 1500 0    50   Input ~ 0
B6_3_high_3.3
Text GLabel 9100 2300 0    50   Input ~ 0
B6_3_low_3.3
Text GLabel 9100 3100 0    50   Input ~ 0
B6_3_enable_3.3
Text GLabel 10000 1500 2    50   Input ~ 0
B6_3_high_5
Text GLabel 10000 2300 2    50   Input ~ 0
B6_3_low_5
Text GLabel 10000 3100 2    50   Input ~ 0
B6_3_enable_5
$Comp
L CmpCst:+5V #PWR0115
U 1 1 5CBDE853
P 9000 2100
F 0 "#PWR0115" H 9000 1950 50  0001 C CNN
F 1 "+5V" H 9015 2273 50  0000 C CNN
F 2 "" H 9000 2100 60  0000 C CNN
F 3 "" H 9000 2100 60  0000 C CNN
	1    9000 2100
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+5V #PWR0116
U 1 1 5CBDE859
P 9000 2900
F 0 "#PWR0116" H 9000 2750 50  0001 C CNN
F 1 "+5V" H 9015 3073 50  0000 C CNN
F 2 "" H 9000 2900 60  0000 C CNN
F 3 "" H 9000 2900 60  0000 C CNN
	1    9000 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 2900 9100 2900
Wire Wire Line
	9100 3000 9000 3000
Wire Wire Line
	9000 3000 9000 2900
Connection ~ 9000 2900
Wire Wire Line
	9000 2100 9100 2100
Wire Wire Line
	9100 2200 9000 2200
Wire Wire Line
	9000 2200 9000 2100
Connection ~ 9000 2100
$Comp
L CmpCst:GND #PWR0117
U 1 1 5CBDE867
P 9000 2400
F 0 "#PWR0117" H 9000 2150 50  0001 C CNN
F 1 "GND" H 9005 2277 50  0000 C CNN
F 2 "" H 9000 2400 60  0000 C CNN
F 3 "" H 9000 2400 60  0000 C CNN
	1    9000 2400
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:GND #PWR0118
U 1 1 5CBDE86D
P 9000 3200
F 0 "#PWR0118" H 9000 2950 50  0001 C CNN
F 1 "GND" H 9005 3077 50  0000 C CNN
F 2 "" H 9000 3200 60  0000 C CNN
F 3 "" H 9000 3200 60  0000 C CNN
	1    9000 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 3200 9100 3200
Wire Wire Line
	9100 2400 9000 2400
Text GLabel 1350 2250 0    50   Input ~ 0
B6_2_high_3.3
Text GLabel 1350 2350 0    50   Input ~ 0
B6_2_low_3.3
Text GLabel 1350 2450 0    50   Input ~ 0
B6_2_enable_3.3
Text GLabel 2650 2450 2    50   Input ~ 0
B6_3_high_3.3
Text GLabel 2650 2350 2    50   Input ~ 0
B6_3_low_3.3
Text GLabel 2650 2250 2    50   Input ~ 0
B6_3_enable_3.3
$Comp
L CmpCst:+5V #PWR0119
U 1 1 5CBDF785
P 2800 1250
F 0 "#PWR0119" H 2800 1100 50  0001 C CNN
F 1 "+5V" H 2815 1423 50  0000 C CNN
F 2 "" H 2800 1250 60  0000 C CNN
F 3 "" H 2800 1250 60  0000 C CNN
	1    2800 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 1250 2650 1250
$Comp
L CmpCst:+3V3 #PWR0120
U 1 1 5CBE084D
P 3000 1250
F 0 "#PWR0120" H 3000 1100 50  0001 C CNN
F 1 "+3V3" H 3015 1423 50  0000 C CNN
F 2 "" H 3000 1250 60  0000 C CNN
F 3 "" H 3000 1250 60  0000 C CNN
	1    3000 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 1250 3000 1350
Wire Wire Line
	3000 1350 2650 1350
$Comp
L CmpCst:GND #PWR0121
U 1 1 5CBE15BE
P 2850 2750
F 0 "#PWR0121" H 2850 2500 50  0001 C CNN
F 1 "GND" H 2855 2627 50  0000 C CNN
F 2 "" H 2850 2750 60  0000 C CNN
F 3 "" H 2850 2750 60  0000 C CNN
	1    2850 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 2750 2650 2750
$Comp
L CmpCst:GND #PWR0122
U 1 1 5CBE1CE0
P 2800 1450
F 0 "#PWR0122" H 2800 1200 50  0001 C CNN
F 1 "GND" H 2805 1327 50  0000 C CNN
F 2 "" H 2800 1450 60  0000 C CNN
F 3 "" H 2800 1450 60  0000 C CNN
	1    2800 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 1450 2800 1450
$Comp
L CmpCst:SN74LV1T126 U10
U 1 1 5CBE2565
P 4950 3600
F 0 "U10" H 5200 3787 60  0000 C CNN
F 1 "SN74LV1T126" H 5200 3681 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 5150 4100 60  0001 C CNN
F 3 "" H 5150 4100 60  0000 C CNN
	1    4950 3600
	1    0    0    -1  
$EndComp
Text GLabel 2650 1650 2    50   Input ~ 0
end_switch_1_3.3
$Comp
L CmpCst:GND #PWR0123
U 1 1 5CBE2615
P 4750 4000
F 0 "#PWR0123" H 4750 3750 50  0001 C CNN
F 1 "GND" H 4755 3877 50  0000 C CNN
F 2 "" H 4750 4000 60  0000 C CNN
F 3 "" H 4750 4000 60  0000 C CNN
	1    4750 4000
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+5V #PWR0124
U 1 1 5CBE2636
P 4750 3700
F 0 "#PWR0124" H 4750 3550 50  0001 C CNN
F 1 "+5V" H 4765 3873 50  0000 C CNN
F 2 "" H 4750 3700 60  0000 C CNN
F 3 "" H 4750 3700 60  0000 C CNN
	1    4750 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 3800 4750 3700
$Comp
L CmpCst:SN74LV1T126 U11
U 1 1 5CBE4AF9
P 4950 5150
F 0 "U11" H 5200 5337 60  0000 C CNN
F 1 "SN74LV1T126" H 5200 5231 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 5150 5650 60  0001 C CNN
F 3 "" H 5150 5650 60  0000 C CNN
	1    4950 5150
	1    0    0    -1  
$EndComp
Text GLabel 5750 5450 2    50   Input ~ 0
end_switch_2_5
$Comp
L CmpCst:GND #PWR0125
U 1 1 5CBE4B01
P 4750 5550
F 0 "#PWR0125" H 4750 5300 50  0001 C CNN
F 1 "GND" H 4755 5427 50  0000 C CNN
F 2 "" H 4750 5550 60  0000 C CNN
F 3 "" H 4750 5550 60  0000 C CNN
	1    4750 5550
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+5V #PWR0126
U 1 1 5CBE4B07
P 4750 5250
F 0 "#PWR0126" H 4750 5100 50  0001 C CNN
F 1 "+5V" H 4765 5423 50  0000 C CNN
F 2 "" H 4750 5250 60  0000 C CNN
F 3 "" H 4750 5250 60  0000 C CNN
	1    4750 5250
	1    0    0    -1  
$EndComp
Text GLabel 1350 1250 0    50   Input ~ 0
end_switch_2_3.3
$Comp
L CmpCst:SN74LV1T126 U12
U 1 1 5CBE64DC
P 7300 3600
F 0 "U12" H 7550 3787 60  0000 C CNN
F 1 "SN74LV1T126" H 7550 3681 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 7500 4100 60  0001 C CNN
F 3 "" H 7500 4100 60  0000 C CNN
	1    7300 3600
	1    0    0    -1  
$EndComp
Text GLabel 8100 3900 2    50   Input ~ 0
encoder_1_5
$Comp
L CmpCst:GND #PWR0127
U 1 1 5CBE64E4
P 7100 4000
F 0 "#PWR0127" H 7100 3750 50  0001 C CNN
F 1 "GND" H 7105 3877 50  0000 C CNN
F 2 "" H 7100 4000 60  0000 C CNN
F 3 "" H 7100 4000 60  0000 C CNN
	1    7100 4000
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+5V #PWR0128
U 1 1 5CBE64EA
P 7100 3700
F 0 "#PWR0128" H 7100 3550 50  0001 C CNN
F 1 "+5V" H 7115 3873 50  0000 C CNN
F 2 "" H 7100 3700 60  0000 C CNN
F 3 "" H 7100 3700 60  0000 C CNN
	1    7100 3700
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:SN74LV1T126 U13
U 1 1 5CBE64F5
P 7300 5150
F 0 "U13" H 7550 5337 60  0000 C CNN
F 1 "SN74LV1T126" H 7550 5231 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 7500 5650 60  0001 C CNN
F 3 "" H 7500 5650 60  0000 C CNN
	1    7300 5150
	1    0    0    -1  
$EndComp
Text GLabel 8100 5450 2    50   Input ~ 0
encoder_2_5
$Comp
L CmpCst:GND #PWR0129
U 1 1 5CBE64FD
P 7100 5550
F 0 "#PWR0129" H 7100 5300 50  0001 C CNN
F 1 "GND" H 7105 5427 50  0000 C CNN
F 2 "" H 7100 5550 60  0000 C CNN
F 3 "" H 7100 5550 60  0000 C CNN
	1    7100 5550
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+5V #PWR0130
U 1 1 5CBE6503
P 7100 5250
F 0 "#PWR0130" H 7100 5100 50  0001 C CNN
F 1 "+5V" H 7115 5423 50  0000 C CNN
F 2 "" H 7100 5250 60  0000 C CNN
F 3 "" H 7100 5250 60  0000 C CNN
	1    7100 5250
	1    0    0    -1  
$EndComp
Text GLabel 1350 1350 0    50   Input ~ 0
encoder_1_3.3
Text GLabel 1350 1450 0    50   Input ~ 0
encoder_2_3.3
$Comp
L CmpCst:RND_Terminal_2P J1
U 1 1 5CBE8D42
P 950 4550
F 0 "J1" H 956 4837 60  0000 C CNN
F 1 "RND_Terminal_2P" H 956 4731 60  0000 C CNN
F 2 "CmpCst:RND_Terminal_2P_381" H 1150 5050 60  0001 C CNN
F 3 "" H 1150 5050 60  0000 C CNN
	1    950  4550
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Switching:TSR_1-2433 U14
U 1 1 5CBE9090
P 2600 4650
F 0 "U14" H 2600 5017 50  0000 C CNN
F 1 "TSR_1-2433" H 2600 4926 50  0000 C CNN
F 2 "CmpCst:TSR_2-2450" H 2600 4500 50  0001 L CIN
F 3 "http://www.tracopower.com/products/tsr1.pdf" H 2600 4650 50  0001 C CNN
	1    2600 4650
	1    0    0    -1  
$EndComp
$Comp
L Device:L L1
U 1 1 5CBE9127
P 1650 4550
F 0 "L1" V 1472 4550 50  0000 C CNN
F 1 "10uH" V 1563 4550 50  0000 C CNN
F 2 "CmpCst:L_Wuerth_4020_Handsoldering" H 1650 4550 50  0001 C CNN
F 3 "~" H 1650 4550 50  0001 C CNN
	1    1650 4550
	0    1    1    0   
$EndComp
Wire Wire Line
	1150 4650 1150 4850
Wire Wire Line
	1800 4550 1900 4550
Wire Wire Line
	1150 4550 1400 4550
Wire Wire Line
	1150 4850 1400 4850
$Comp
L CmpCst:C_Elko C1
U 1 1 5CBF6FCF
P 1400 4700
F 0 "C1" H 1528 4746 50  0000 L CNN
F 1 "4.7uF" H 1528 4655 50  0000 L CNN
F 2 "CmpCst:C_1206_HandSoldering" H 1438 4550 30  0001 C CNN
F 3 "" H 1400 4700 60  0000 C CNN
	1    1400 4700
	1    0    0    -1  
$EndComp
Connection ~ 1400 4550
Wire Wire Line
	1400 4550 1500 4550
Connection ~ 1400 4850
Wire Wire Line
	1400 4850 1900 4850
$Comp
L CmpCst:C_Elko C2
U 1 1 5CBF7023
P 1900 4700
F 0 "C2" H 2028 4746 50  0000 L CNN
F 1 "4.7uF" H 2028 4655 50  0000 L CNN
F 2 "CmpCst:C_1206_HandSoldering" H 1938 4550 30  0001 C CNN
F 3 "" H 1900 4700 60  0000 C CNN
	1    1900 4700
	1    0    0    -1  
$EndComp
Connection ~ 1900 4550
Wire Wire Line
	1900 4550 2200 4550
Connection ~ 1900 4850
Wire Wire Line
	1900 4850 2600 4850
$Comp
L CmpCst:C_Elko C4
U 1 1 5CBF706B
P 3550 4700
F 0 "C4" H 3678 4746 50  0000 L CNN
F 1 "470uF" H 3678 4655 50  0000 L CNN
F 2 "CmpCst:C_1206_HandSoldering" H 3588 4550 30  0001 C CNN
F 3 "" H 3550 4700 60  0000 C CNN
	1    3550 4700
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:C C3
U 1 1 5CBF70F8
P 3100 4700
F 0 "C3" H 3215 4746 50  0000 L CNN
F 1 "100nF" H 3215 4655 50  0000 L CNN
F 2 "CmpCst:C_0805_HandSoldering" H 3138 4550 30  0001 C CNN
F 3 "" H 3100 4700 60  0000 C CNN
	1    3100 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	2600 4850 3100 4850
Connection ~ 2600 4850
Wire Wire Line
	3000 4550 3100 4550
Connection ~ 3100 4550
Connection ~ 3100 4850
$Comp
L CmpCst:GND #PWR0131
U 1 1 5CBFFC13
P 2600 4850
F 0 "#PWR0131" H 2600 4600 50  0001 C CNN
F 1 "GND" H 2605 4727 50  0000 C CNN
F 2 "" H 2600 4850 60  0000 C CNN
F 3 "" H 2600 4850 60  0000 C CNN
	1    2600 4850
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+5V #PWR0132
U 1 1 5CBFFC48
P 3100 4550
F 0 "#PWR0132" H 3100 4400 50  0001 C CNN
F 1 "+5V" H 3115 4723 50  0000 C CNN
F 2 "" H 3100 4550 60  0000 C CNN
F 3 "" H 3100 4550 60  0000 C CNN
	1    3100 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 4550 3550 4550
Wire Wire Line
	3100 4850 3550 4850
$Comp
L CmpCst:+3V3 #PWR0133
U 1 1 5CC12D22
P 1100 3150
F 0 "#PWR0133" H 1100 3000 50  0001 C CNN
F 1 "+3V3" H 1115 3323 50  0000 C CNN
F 2 "" H 1100 3150 60  0000 C CNN
F 3 "" H 1100 3150 60  0000 C CNN
	1    1100 3150
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:GND #PWR0134
U 1 1 5CC1EE97
P 1150 3650
F 0 "#PWR0134" H 1150 3400 50  0001 C CNN
F 1 "GND" H 1155 3527 50  0000 C CNN
F 2 "" H 1150 3650 60  0000 C CNN
F 3 "" H 1150 3650 60  0000 C CNN
	1    1150 3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1150 3650 1350 3650
Text GLabel 1350 3250 0    50   Input ~ 0
SPI_RPI_cs
Text GLabel 1350 3350 0    50   Input ~ 0
SPI_RPI_clk
Text GLabel 1350 3450 0    50   Input ~ 0
SPI_RPI_mosi
Text GLabel 1350 3550 0    50   Input ~ 0
SPI_RPI_miso
$Comp
L CmpCst:CONN_02X05 J2
U 1 1 5CC215F2
P 1650 5800
F 0 "J2" H 1650 6215 50  0000 C CNN
F 1 "CONN_02X05" H 1650 6124 50  0000 C CNN
F 2 "CmpCst:IDC_Header_Straight_10pins" H 1650 4600 50  0001 C CNN
F 3 "" H 1650 4600 50  0001 C CNN
	1    1650 5800
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:GND #PWR0135
U 1 1 5CC216E8
P 1400 6000
F 0 "#PWR0135" H 1400 5750 50  0001 C CNN
F 1 "GND" H 1405 5877 50  0000 C CNN
F 2 "" H 1400 6000 60  0000 C CNN
F 3 "" H 1400 6000 60  0000 C CNN
	1    1400 6000
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:GND #PWR0136
U 1 1 5CC2171F
P 1900 6000
F 0 "#PWR0136" H 1900 5750 50  0001 C CNN
F 1 "GND" H 1905 5877 50  0000 C CNN
F 2 "" H 1900 6000 60  0000 C CNN
F 3 "" H 1900 6000 60  0000 C CNN
	1    1900 6000
	1    0    0    -1  
$EndComp
Text GLabel 1400 5800 0    50   Input ~ 0
SPI_RPI_cs
Text GLabel 1900 5800 2    50   Input ~ 0
SPI_RPI_clk
Text GLabel 1400 5900 0    50   Input ~ 0
SPI_RPI_mosi
Text GLabel 1900 5900 2    50   Input ~ 0
SPI_RPI_miso
$Comp
L CmpCst:R R1
U 1 1 5CC21B93
P 1950 4200
F 0 "R1" V 1743 4200 50  0000 C CNN
F 1 "OPEN" V 1834 4200 50  0000 C CNN
F 2 "CmpCst:R_1206_HandSoldering" V 1880 4200 30  0001 C CNN
F 3 "" H 1950 4200 30  0000 C CNN
	1    1950 4200
	0    1    1    0   
$EndComp
Wire Wire Line
	1400 4550 1400 4200
Wire Wire Line
	1400 4200 1800 4200
Wire Wire Line
	2100 4200 3550 4200
Wire Wire Line
	3550 4200 3550 4550
Connection ~ 3550 4550
$Comp
L CmpCst:R R2
U 1 1 5CC2B645
P 1150 5300
F 0 "R2" V 943 5300 50  0000 C CNN
F 1 "OPEN" V 1034 5300 50  0000 C CNN
F 2 "CmpCst:R_1206_HandSoldering" V 1080 5300 30  0001 C CNN
F 3 "" H 1150 5300 30  0000 C CNN
	1    1150 5300
	0    1    1    0   
$EndComp
Wire Wire Line
	1400 5600 1400 5300
Wire Wire Line
	1400 5300 1300 5300
Wire Wire Line
	1900 5600 1900 5300
Wire Wire Line
	1900 5300 1400 5300
Connection ~ 1400 5300
$Comp
L CmpCst:+3V3 #PWR0137
U 1 1 5CC3071B
P 800 5300
F 0 "#PWR0137" H 800 5150 50  0001 C CNN
F 1 "+3V3" H 815 5473 50  0000 C CNN
F 2 "" H 800 5300 60  0000 C CNN
F 3 "" H 800 5300 60  0000 C CNN
	1    800  5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	800  5300 1000 5300
Wire Wire Line
	1100 3150 1350 3150
$Comp
L CmpCst:+3V3 #PWR0138
U 1 1 5CC3E3D8
P 650 3750
F 0 "#PWR0138" H 650 3600 50  0001 C CNN
F 1 "+3V3" H 665 3923 50  0000 C CNN
F 2 "" H 650 3750 60  0000 C CNN
F 3 "" H 650 3750 60  0000 C CNN
	1    650  3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 3750 650  3750
$Comp
L CmpCst:RND_Terminal_3P J3
U 1 1 5CC51842
P 850 7400
F 0 "J3" H 856 7687 60  0000 C CNN
F 1 "RND_Terminal_3P" H 856 7581 60  0000 C CNN
F 2 "CmpCst:RND_Terminal_3P_381" H 1050 7900 60  0001 C CNN
F 3 "" H 1050 7900 60  0000 C CNN
	1    850  7400
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:RND_Terminal_3P J4
U 1 1 5CC542FE
P 1900 7400
F 0 "J4" H 1906 7687 60  0000 C CNN
F 1 "RND_Terminal_3P" H 1906 7581 60  0000 C CNN
F 2 "CmpCst:RND_Terminal_3P_381" H 2100 7900 60  0001 C CNN
F 3 "" H 2100 7900 60  0000 C CNN
	1    1900 7400
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:RND_Terminal_3P J5
U 1 1 5CC54386
P 3000 7400
F 0 "J5" H 3006 7687 60  0000 C CNN
F 1 "RND_Terminal_3P" H 3006 7581 60  0000 C CNN
F 2 "CmpCst:RND_Terminal_3P_381" H 3200 7900 60  0001 C CNN
F 3 "" H 3200 7900 60  0000 C CNN
	1    3000 7400
	1    0    0    -1  
$EndComp
Text GLabel 1050 7400 2    50   Input ~ 0
B6_1_high_5
Text GLabel 1050 7500 2    50   Input ~ 0
B6_1_low_5
Text GLabel 1050 7600 2    50   Input ~ 0
B6_1_enable_5
Text GLabel 2100 7400 2    50   Input ~ 0
B6_2_high_5
Text GLabel 2100 7500 2    50   Input ~ 0
B6_2_low_5
Text GLabel 2100 7600 2    50   Input ~ 0
B6_2_enable_5
Text GLabel 3200 7400 2    50   Input ~ 0
B6_3_high_5
Text GLabel 3200 7500 2    50   Input ~ 0
B6_3_low_5
Text GLabel 3200 7600 2    50   Input ~ 0
B6_3_enable_5
$Comp
L CmpCst:GND #PWR0139
U 1 1 5CC70FF9
P 1250 3050
F 0 "#PWR0139" H 1250 2800 50  0001 C CNN
F 1 "GND" H 1255 2927 50  0000 C CNN
F 2 "" H 1250 3050 60  0000 C CNN
F 3 "" H 1250 3050 60  0000 C CNN
	1    1250 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 3050 1350 3050
$Comp
L CmpCst:GND #PWR0140
U 1 1 5CC73A78
P 2850 3050
F 0 "#PWR0140" H 2850 2800 50  0001 C CNN
F 1 "GND" H 2855 2927 50  0000 C CNN
F 2 "" H 2850 3050 60  0000 C CNN
F 3 "" H 2850 3050 60  0000 C CNN
	1    2850 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 3050 2850 3050
$Comp
L CmpCst:RND_Terminal_2P J6
U 1 1 5CC794C1
P 10100 4250
F 0 "J6" H 10106 4537 60  0000 C CNN
F 1 "RND_Terminal_2P" H 10106 4431 60  0000 C CNN
F 2 "CmpCst:RND_Terminal_2P_381" H 10300 4750 60  0001 C CNN
F 3 "" H 10300 4750 60  0000 C CNN
	1    10100 4250
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:RND_Terminal_2P J7
U 1 1 5CC7966D
P 10100 4900
F 0 "J7" H 10106 5187 60  0000 C CNN
F 1 "RND_Terminal_2P" H 10106 5081 60  0000 C CNN
F 2 "CmpCst:RND_Terminal_2P_381" H 10300 5400 60  0001 C CNN
F 3 "" H 10300 5400 60  0000 C CNN
	1    10100 4900
	1    0    0    -1  
$EndComp
Text GLabel 4550 3900 0    50   Input ~ 0
end_switch_1_3.3
Text GLabel 4650 5450 0    50   Input ~ 0
end_switch_2_3.3
Text GLabel 7000 3900 0    50   Input ~ 0
encoder_1_3.3
Text GLabel 5750 3900 2    50   Input ~ 0
end_switch_1_5
Text GLabel 7000 5450 0    50   Input ~ 0
encoder_2_3.3
Text GLabel 10300 4250 2    50   Input ~ 0
end_switch_1_5
Text GLabel 10300 4350 2    50   Input ~ 0
end_switch_2_5
Text GLabel 10300 4900 2    50   Input ~ 0
encoder_1_5
Text GLabel 10300 5000 2    50   Input ~ 0
encoder_2_5
$Comp
L CmpCst:SN74LV1T126 U15
U 1 1 5CCA6712
P 5450 4700
F 0 "U15" H 5700 4887 60  0000 C CNN
F 1 "SN74LV1T126" H 5700 4781 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 5650 5200 60  0001 C CNN
F 3 "" H 5650 5200 60  0000 C CNN
	1    5450 4700
	-1   0    0    1   
$EndComp
$Comp
L CmpCst:GND #PWR0141
U 1 1 5CCA6866
P 5650 4300
F 0 "#PWR0141" H 5650 4050 50  0001 C CNN
F 1 "GND" H 5650 4350 50  0000 C CNN
F 2 "" H 5650 4300 60  0000 C CNN
F 3 "" H 5650 4300 60  0000 C CNN
	1    5650 4300
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+3V3 #PWR0142
U 1 1 5CCA699D
P 5650 4500
F 0 "#PWR0142" H 5650 4350 50  0001 C CNN
F 1 "+3V3" H 5800 4550 50  0000 C CNN
F 2 "" H 5650 4500 60  0000 C CNN
F 3 "" H 5650 4500 60  0000 C CNN
	1    5650 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 4500 5650 4600
Connection ~ 4750 3700
Wire Wire Line
	4750 4400 4650 4400
Wire Wire Line
	4650 4400 4650 3900
Wire Wire Line
	4650 3900 4750 3900
Wire Wire Line
	4650 3900 4550 3900
Connection ~ 4650 3900
Connection ~ 5650 4500
Wire Wire Line
	5650 4400 5750 4400
Wire Wire Line
	5750 4400 5750 3900
Wire Wire Line
	5750 3900 5650 3900
Wire Wire Line
	4750 5350 4750 5250
Connection ~ 4750 5250
$Comp
L CmpCst:SN74LV1T126 U16
U 1 1 5CCCED40
P 5450 6250
F 0 "U16" H 5700 6437 60  0000 C CNN
F 1 "SN74LV1T126" H 5700 6331 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 5650 6750 60  0001 C CNN
F 3 "" H 5650 6750 60  0000 C CNN
	1    5450 6250
	-1   0    0    1   
$EndComp
Wire Wire Line
	4750 5450 4650 5450
Wire Wire Line
	4650 5450 4650 5950
Wire Wire Line
	4650 5950 4750 5950
Wire Wire Line
	5650 5450 5750 5450
Wire Wire Line
	5750 5450 5750 5950
Wire Wire Line
	5750 5950 5650 5950
$Comp
L CmpCst:+3V3 #PWR0143
U 1 1 5CCD48B4
P 5650 6050
F 0 "#PWR0143" H 5650 5900 50  0001 C CNN
F 1 "+3V3" H 5800 6100 50  0000 C CNN
F 2 "" H 5650 6050 60  0000 C CNN
F 3 "" H 5650 6050 60  0000 C CNN
	1    5650 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 6050 5650 6150
Connection ~ 5650 6050
$Comp
L CmpCst:GND #PWR0144
U 1 1 5CCD7762
P 5650 5850
F 0 "#PWR0144" H 5650 5600 50  0001 C CNN
F 1 "GND" H 5650 5900 50  0000 C CNN
F 2 "" H 5650 5850 60  0000 C CNN
F 3 "" H 5650 5850 60  0000 C CNN
	1    5650 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7100 3700 7100 3800
Connection ~ 7100 3700
$Comp
L CmpCst:SN74LV1T126 U17
U 1 1 5CCE05A2
P 7800 4700
F 0 "U17" H 8050 4887 60  0000 C CNN
F 1 "SN74LV1T126" H 8050 4781 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 8000 5200 60  0001 C CNN
F 3 "" H 8000 5200 60  0000 C CNN
	1    7800 4700
	-1   0    0    1   
$EndComp
$Comp
L CmpCst:GND #PWR0145
U 1 1 5CCE0610
P 8000 4300
F 0 "#PWR0145" H 8000 4050 50  0001 C CNN
F 1 "GND" H 8000 4350 50  0000 C CNN
F 2 "" H 8000 4300 60  0000 C CNN
F 3 "" H 8000 4300 60  0000 C CNN
	1    8000 4300
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+3V3 #PWR0146
U 1 1 5CCE065B
P 8000 4500
F 0 "#PWR0146" H 8000 4350 50  0001 C CNN
F 1 "+3V3" H 8150 4550 50  0000 C CNN
F 2 "" H 8000 4500 60  0000 C CNN
F 3 "" H 8000 4500 60  0000 C CNN
	1    8000 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 4500 8000 4600
Connection ~ 8000 4500
Wire Wire Line
	8100 4400 8100 3900
Wire Wire Line
	8100 3900 8000 3900
Wire Wire Line
	8000 4400 8100 4400
Wire Wire Line
	7100 3900 7000 3900
Wire Wire Line
	7000 3900 7000 4400
Wire Wire Line
	7000 4400 7100 4400
$Comp
L CmpCst:SN74LV1T126 U18
U 1 1 5CCF49AA
P 7800 6250
F 0 "U18" H 8050 6437 60  0000 C CNN
F 1 "SN74LV1T126" H 8050 6331 60  0000 C CNN
F 2 "CmpCst:SOT-23-5_Handsoldering" H 8000 6750 60  0001 C CNN
F 3 "" H 8000 6750 60  0000 C CNN
	1    7800 6250
	-1   0    0    1   
$EndComp
Wire Wire Line
	7100 5250 7100 5350
Connection ~ 7100 5250
Wire Wire Line
	7100 5450 7000 5450
Wire Wire Line
	7100 5950 7000 5950
Wire Wire Line
	7000 5950 7000 5450
Wire Wire Line
	8000 5450 8100 5450
Wire Wire Line
	8100 5450 8100 5950
Wire Wire Line
	8100 5950 8000 5950
$Comp
L CmpCst:GND #PWR0147
U 1 1 5CD001D3
P 8000 5850
F 0 "#PWR0147" H 8000 5600 50  0001 C CNN
F 1 "GND" H 8000 5900 50  0000 C CNN
F 2 "" H 8000 5850 60  0000 C CNN
F 3 "" H 8000 5850 60  0000 C CNN
	1    8000 5850
	1    0    0    -1  
$EndComp
$Comp
L CmpCst:+3V3 #PWR0148
U 1 1 5CD00220
P 8000 6050
F 0 "#PWR0148" H 8000 5900 50  0001 C CNN
F 1 "+3V3" H 8150 6100 50  0000 C CNN
F 2 "" H 8000 6050 60  0000 C CNN
F 3 "" H 8000 6050 60  0000 C CNN
	1    8000 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 6050 8000 6150
Connection ~ 8000 6050
Text Notes 7300 6250 0    50   ~ 0
NICHT\nBESTÜCKT
Text Notes 4950 6250 0    50   ~ 0
NICHT\nBESTÜCKT
Text Notes 4950 4700 0    50   ~ 0
NICHT\nBESTÜCKT
Text Notes 7300 4700 0    50   ~ 0
NICHT\nBESTÜCKT
$EndSCHEMATC