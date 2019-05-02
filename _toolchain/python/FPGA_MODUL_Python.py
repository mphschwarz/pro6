#####################################################################
# Pythonskript für die Ansteuerungn des FPGA - Moduls
# ABB Technikerschule www.abbts.ch
# © P. Helfenstein Dipl. EL. Ing. FH
#####################################################################
# Import der benötigten Bibliotheken
from pyftdi.spi import SpiController # http://eblot.github.io/pyftdi/
import ctypes as ct
#####################################################################
class FPGA_MODUL():
    def __init__(self):
        # Eingänge
        self.adc_u4 = 0 #
        self.adc_u8 = 0  #
        self.adc_u9 = 0  #
        self.ind_sensor_es_links = False  #
        self.ind_sensor_es_rechts = False  #
        self.ind_sensor_es_nullpos = False  #
        self.qe1_cw = False  #
        self.qe1_ccw = False  #
        self.qe1_counter = 0 #
        self.qe1_speed = 0 #
        self.qe2_cw = False  #
        self.qe2_ccw = False  #
        self.qe2_counter = 0  #
        self.qe2_speed = 0  #
        # Ausgänge
        self.rgb1 = [0, 0, 0] #
        self.rgb2 = [0, 0, 0] #
        self.rgb3 = [0, 0, 0] #
        self.dac_u5 = 0 #
        self.dac_u5_adc_u8 = False #
        self.antrieb_enable = False #
        self.antrieb_pwm = 0 #
        self.pulsblocker = 0 # Pulsblocker (Strombegrenzer)
        self.luefter_pwm = 0 #
        self.qe1_reset = False #
        self.qe2_reset = False  #
        self.spi_ft2232_to_j7 = False  #


    def test_var_range_read(selfs):
        print("")

    def test_var_range_write(self):
        #
        self.dac_u5 = int(self.dac_u5)
        if (self.dac_u5 > 4095): self.dac_u5 = 4095
        if (self.dac_u5 < 0): self.dac_u5 = 0
        #
        self.antrieb_pwm = int(self.antrieb_pwm)
        if (self.antrieb_pwm > 4095): self.antrieb_pwm = 4095
        if (self.antrieb_pwm < -4095): self.antrieb_pwm = -4095
        #
        self.pulsblocker = int(self.pulsblocker)
        if (self.pulsblocker > 4095): self.pulsblocker = 4095
        if (self.pulsblocker < 0): self.pulsblocker = 0
        #
        self.luefter_pwm = int(self.luefter_pwm)
        if (self.luefter_pwm > 4095): self.luefter_pwm = 4095
        if (self.luefter_pwm < 0): self.luefter_pwm = 0
#####################################################################
# Hilfsklassen
class SPI_8Bit(ct.Union):
    _fields_ = [('byte_', ct.c_ubyte)]

class SPI_16Bit(ct.Union):
    _fields_ = [('iValue', ct.c_int16),
                ('uiValue', ct.c_uint16),
                ('byte_', ct.c_ubyte * 2)]

class SPI_32Bit(ct.Union):
    _fields_ = [('diValue', ct.c_int32),
                ('udiValue', ct.c_uint32),
                ('byte_', ct.c_ubyte * 4)]
#####################################################################
class HAL():
    def __init__(self):
        self.fpga = FPGA_MODUL()
        self.spi = None # Instanzierung erfolgt in spi_open()
        self.client = None # Instanzierung erfolgt in spi_open()

    def read_input(self):
        spi16Bit = SPI_16Bit()
        spi32Bit = SPI_32Bit()
        ##################################
        # BANK 0
        write_buf = [0b10100000, 0, (32 + 5), 1, 0] # Kommando
        write_buf.extend([0 for i in range((write_buf[2] - len(write_buf)))])
        read_buf = self.spi_read_write(write_buf)
        #
        spi16Bit.byte_[1] = read_buf[5]
        spi16Bit.byte_[0] = read_buf[6]
        self.fpga.adc_u4 = spi16Bit.uiValue # ADC U4
        #
        spi16Bit.byte_[1] = read_buf[7]
        spi16Bit.byte_[0] = read_buf[8]
        self.fpga.adc_u8 = spi16Bit.uiValue  # ADC U8
        #
        spi16Bit.byte_[1] = read_buf[9]
        spi16Bit.byte_[0] = read_buf[10]
        self.fpga.adc_u9 = spi16Bit.uiValue  # ADC U9
        #
        self.ind_sensor_es_links = False
        self.ind_sensor_es_rechts = False
        self.ind_sensor_es_nullpos = False
        self.qe1_cw = False
        self.qe1_ccw = False
        self.qe2_cw = False
        self.qe2_ccw = False
        if ((read_buf[11] & 0b01000000) > 0): self.fpga.ind_sensor_es_links = True
        if ((read_buf[11] & 0b00100000) > 0): self.fpga.ind_sensor_es_rechts = True
        if ((read_buf[11] & 0b00010000) > 0): self.fpga.ind_sensor_es_nullpos = True
        if ((read_buf[11] & 0b00001000) > 0): self.fpga.qe1_cw = True
        if ((read_buf[11] & 0b00000100) > 0): self.fpga.qe1_ccw = True
        if ((read_buf[11] & 0b00000010) > 0): self.fpga.qe2_cw = True
        if ((read_buf[11] & 0b00000001) > 0): self.fpga.qe2_ccw = True
        # QE1 Counter
        spi32Bit.byte_[3] = read_buf[12]
        spi32Bit.byte_[2] = read_buf[13]
        spi32Bit.byte_[1] = read_buf[14]
        spi32Bit.byte_[0] = read_buf[15]
        hal.fpga.qe1_counter = spi32Bit.diValue
        # QE1 Speed
        spi32Bit.byte_[3] = read_buf[16]
        spi32Bit.byte_[2] = read_buf[17]
        spi32Bit.byte_[1] = read_buf[18]
        spi32Bit.byte_[0] = read_buf[19]
        hal.fpga.qe1_speed = spi32Bit.diValue
        # QE2 Counter
        spi32Bit.byte_[3] = read_buf[20]
        spi32Bit.byte_[2] = read_buf[21]
        spi32Bit.byte_[1] = read_buf[22]
        spi32Bit.byte_[0] = read_buf[23]
        hal.fpga.qe2_counter = spi32Bit.diValue
        # QE2 Speed
        spi32Bit.byte_[3] = read_buf[24]
        spi32Bit.byte_[2] = read_buf[25]
        spi32Bit.byte_[1] = read_buf[26]
        spi32Bit.byte_[0] = read_buf[27]
        hal.fpga.qe2_speed = spi32Bit.diValue
        ##################################
        self.fpga.test_var_range_read()

    def write_output(self):
        spi8bit = SPI_8Bit()
        spi16Bit = SPI_16Bit()
        spi32Bit = SPI_32Bit()
        self.fpga.test_var_range_write()
        ##################################
        # BANK 0
        write_buf = [0b11000000, 0, (32 + 5), 0, 0] # Kommando
        write_buf.extend([0, 0])
        write_buf.extend(self.fpga.rgb1)  # RGB 1 PL9823
        write_buf.extend(self.fpga.rgb2)  # RGB 2 PL9823
        write_buf.extend(self.fpga.rgb3)  # RGB 3 PL9823
        write_buf.extend([0 for i in range((write_buf[2] - len(write_buf)))])
        self.spi_read_write(write_buf)
        ##################################
        # BANK 1
        write_buf = [0b11000000, 0, (32 + 5), 1, 0]  # Kommando
        #
        spi16Bit.uiValue = self.fpga.dac_u5  # DAC U5
        if (self.fpga.dac_u5_adc_u8 == True): spi16Bit.uiValue = spi16Bit.uiValue | 0b1000000000000000
        write_buf.extend(spi16Bit.byte_[::-1])
        #
        spi16Bit.iValue = self.fpga.antrieb_pwm  # DC - Motor
        if (self.fpga.antrieb_enable == True): spi16Bit.uiValue = spi16Bit.uiValue | 0b1000000000000000
        write_buf.extend(spi16Bit.byte_[::-1])
        #
        spi16Bit.uiValue = self.fpga.luefter_pwm  # Lüfter PWM
        write_buf.extend(spi16Bit.byte_[::-1])
        #
        spi8bit.byte_ = 0
        if (self.fpga.spi_ft2232_to_j7 == True): spi8bit.byte_ = spi8bit.byte_ | 0b10000000  # Monitoring SPI des FT2232 auf J7
        # RESERVE
        if (self.fpga.qe2_reset == True):        spi8bit.byte_ = spi8bit.byte_ | 0b00000010 # Reset Quadraturencoder 1
        if (self.fpga.qe1_reset == True):        spi8bit.byte_ = spi8bit.byte_ | 0b00000001 # Reset Quadraturencoder 2
        write_buf.extend([spi8bit.byte_])  # QE

        #
        spi16Bit.uiValue = self.fpga.pulsblocker  # Strombegrenzer
        write_buf.extend(spi16Bit.byte_[::-1])
        #
        write_buf.extend([0 for i in range((write_buf[2] - len(write_buf)))])
        #
        self.spi_read_write(write_buf)
        '''
        # 8 x 8 RGB Matrix (Einführung Arrays und Listen in SW-Engineering bzw. Python)
        for i in range(8):
            write_buf = [0b11000000, 0, (24 + 5), (i + 81), 0]  # write BANK 81-88
            RGB_value = [1, 0, 0]
            for k in range(8):
                write_buf.extend(RGB_value)  # RGB
            self.spi_read_write(write_buf)
        #
        '''
        ##################################

    def spi_open(self):
        self.spi = SpiController()  # Instanzierung SPI Controller
        self.spi.configure('ftdi://ftdi:2232h/1')  # URL FTDI Chip (ftdi://ftdi:232h/1', 'ftdi:///1')
        self.client = self.spi.get_port(cs=0, freq=1E6, mode=0)  # SPI Host Verbindung

    def spi_read_write(self, write_buf):
        return self.client.exchange(out=write_buf, duplex=True).tobytes()

    def spi_close(self):
        self.spi.terminate()
#####################################################################
# Mainroutine
if __name__ == "__main__":
    hal = HAL()
    hal.spi_open()
    hal.read_input()
    ##################################
    # Eingänge (https://pyformat.info/)
    print("ADC U4: {:04d} | 0x{:04X} | 0b{:08b}".format(hal.fpga.adc_u4, hal.fpga.adc_u4, hal.fpga.adc_u4))
    print("ADC U8: {:04d} | 0x{:04X} | 0b{:08b}".format(hal.fpga.adc_u8, hal.fpga.adc_u8, hal.fpga.adc_u8))
    print("ADC U9: {:04d} | 0x{:04X} | 0b{:08b}".format(hal.fpga.adc_u9, hal.fpga.adc_u9, hal.fpga.adc_u9))
    #
    print("Quadraturencoder 1 COUNTER {:d}:".format(hal.fpga.qe1_counter))
    print("Quadraturencoder 1 CW {:b}:".format(hal.fpga.qe1_cw))
    print("Quadraturencoder 1 CCW {:b}:".format(hal.fpga.qe1_ccw))
    #
    ##################################
    # Ausgänge
    hal.fpga.rgb1 = [2, 0, 0] # 0 - 2^8
    hal.fpga.rgb2 = [0, 2, 0] # 0 - 2^8
    hal.fpga.rgb3 = [0, 0, 5] # 0 - 2^8
    #
    hal.fpga.antrieb_enable = True
    hal.fpga.antrieb_pwm = 1000  # 0 - 2^12
    hal.fpga.pulsblocker = 1500  # 0 - 2^12
    #
    hal.fpga.dac_u5_adc_u8 = True
    hal.fpga.dac_u5 = 1000 # 0 - 2^12 
    #
    hal.fpga.qe1_reset = False
    #
    hal.fpga.spi_ft2232_to_j7 = False # !!!!!!!!!!!!!!!!!!!!!!
    ##################################
    hal.write_output()
    hal.spi_close()
#####################################################################
