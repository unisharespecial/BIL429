
; CC8E Version 1.3F, Copyright (c) B Knudsen Data
; C compiler for the PIC18 microcontrollers
; ************   2. Dec 2013   0:37  *************

	processor  PIC18F452
	radix  DEC

	__config 0x300001, 0xF1
	__config 0x300002, 0xF8
	__config 0x300003, 0xFE

INTCON      EQU   0xFF2
Zero_       EQU   2
TRISE       EQU   0xF96
TRISD       EQU   0xF95
TRISC       EQU   0xF94
TRISB       EQU   0xF93
TRISA       EQU   0xF92
PORTD       EQU   0xF83
PORTC       EQU   0xF82
PORTB       EQU   0xF81
RBIF        EQU   0
INT0IF      EQU   1
GIE         EQU   7
t           EQU   0x00
x           EQU   0x02

	GOTO main

  ; FILE lab3_1.c
			;//Polling Tabanlý Klavyeden Basýlan Butonu Algýlama
			;
			;// Mikrodenetleyici Timer ve Clock Ayarlamalarý
			;#pragma config[1] = 0xF1 // Osilatör: XT
			;#pragma config[2] = 0xFE & 0xF9 // PWRT açýk, BOR kapalý
			;#pragma config[3] = 0xFE // Watchdog Timer kapalý
			;
			;void ayarlar(); // Port ayarlamalarýnýn yapýldýðý fonksiyonlarýn tanýmý
			;void bekle(unsigned long t);	
			;void kesme();	
			;
			;
			;void kesme() //kesme gelince yapilacak komutlar, kesmede calisacak fonksiyon main fonksiyonunun ustunde yazilir...	
			;{
kesme
			;	INTCON=0x90; // kesmeler acilir RBO/INT0 girisi interrupt enable edilir.
	MOVLW 144
	MOVWF INTCON,0
			;	INT0IF=0;  // yeni kesmeler gelmesi icin butona bagli olan INT0 portundaki interrupt flagi kapatilir.
	BCF   0xFF2,INT0IF,0
			;	GIE=1;	//kesmeler acilir, yeni kesme gelmesine musade edilir
	BSF   0xFF2,GIE,0
			;}	
	RETURN
			;void main()
			;{	
main
			;	ayarlar(); // Port Ayarlamalarý Programýn ilk adýmýnda yapýlýyor.
	RCALL ayarlar
			;
			;//-----------------------------------------------	
			;anadongu:
			;
			;	PORTB.0=1; // Port B' nin 0. biti high yapýlýyor
m001	BSF   PORTB,0,0
			;	PORTB.1=0; // Port B' nin 1. biti low yapýlýyor
	BCF   PORTB,1,0
			;	PORTB.2=0; // Port B' nin 2. biti low yapýlýyor
	BCF   PORTB,2,0
			;	if(RBIF==1){
	BTFSS 0xFF2,RBIF,0
	BRA   m005
			;	if(PORTB.5 == 1){ // Port B' nin 5. biti high olmuþsa göstergede 1 göster.
	BTFSS PORTB,5,0
	BRA   m002
			;		PORTD=0x06;
	MOVLW 6
	MOVWF PORTD,0
			;		bekle(300);
	MOVLW 44
	MOVWF t,0
	MOVLW 1
	MOVWF t+1,0
	RCALL bekle
			;		PORTD=0;
	CLRF  PORTD,0
			;	}
			;	if(PORTB.4 == 1){ // Port B' nin 4. biti high olmuþsa göstergede 2 göster.
m002	BTFSS PORTB,4,0
	BRA   m003
			;		PORTD=0x5B;
	MOVLW 91
	MOVWF PORTD,0
			;		bekle(300);
	MOVLW 44
	MOVWF t,0
	MOVLW 1
	MOVWF t+1,0
	RCALL bekle
			;		PORTD=0;
	CLRF  PORTD,0
			;	}
			;	if(PORTB.3 == 1){ // Port B' nin 3. biti high olmuþsa göstergede 3 göster.
m003	BTFSS PORTB,3,0
	BRA   m004
			;		PORTD=0x4F;
	MOVLW 79
	MOVWF PORTD,0
			;		bekle(300);
	MOVLW 44
	MOVWF t,0
	MOVLW 1
	MOVWF t+1,0
	RCALL bekle
			;		PORTD=0;
	CLRF  PORTD,0
			;	}
			;	if(PORTB.6 == 1){// Port B' nin 6. biti high olmuþsa göstergede 0 göster.
m004	BTFSS PORTB,6,0
	BRA   m005
			;		PORTD=0x03F;
	MOVLW 63
	MOVWF PORTD,0
			;		bekle(300);
	MOVLW 44
	MOVWF t,0
	MOVLW 1
	MOVWF t+1,0
	RCALL bekle
			;		PORTD=0;
	CLRF  PORTD,0
			;	}
			;}
			;	if(RBIF==0){
m005	BTFSC 0xFF2,RBIF,0
	BRA   m011
			;	PORTB.1=1; // Port B' nin 1. biti high, 0 ve 2. bitleri low yapýlýr.
	BSF   PORTB,1,0
			;	PORTB.0=0;
	BCF   PORTB,0,0
			;	PORTB.2=0;
	BCF   PORTB,2,0
			;	if(PORTB.5 == 1){ // Port B' nin 5. biti high olmuþsa göstergede 4 göster.
	BTFSS PORTB,5,0
	BRA   m006
			;		PORTD=0x66;
	MOVLW 102
	MOVWF PORTD,0
			;		bekle(300);
	MOVLW 44
	MOVWF t,0
	MOVLW 1
	MOVWF t+1,0
	RCALL bekle
			;		PORTD=0;
	CLRF  PORTD,0
			;	}
			;	if(PORTB.4 == 1){ // Port B' nin 4. biti high olmuþsa göstergede 5 göster.
m006	BTFSS PORTB,4,0
	BRA   m007
			;		PORTD=0x6D;
	MOVLW 109
	MOVWF PORTD,0
			;		bekle(300);
	MOVLW 44
	MOVWF t,0
	MOVLW 1
	MOVWF t+1,0
	RCALL bekle
			;		PORTD=0;
	CLRF  PORTD,0
			;	}
			;	if(PORTB.3 == 1){ // Port B' nin 3. biti high olmuþsa göstergede 6 göster.
m007	BTFSS PORTB,3,0
	BRA   m008
			;		PORTD=0x7D;
	MOVLW 125
	MOVWF PORTD,0
			;		bekle(300);
	MOVLW 44
	MOVWF t,0
	MOVLW 1
	MOVWF t+1,0
	RCALL bekle
			;		PORTD=0;
	CLRF  PORTD,0
			;	}
			;	
			;	PORTB.2=1; // Port B' nin 2. biti high, 0 ve 1. bitleri low yapýlýr.
m008	BSF   PORTB,2,0
			;	PORTB.0=0;
	BCF   PORTB,0,0
			;	PORTB.1=0;
	BCF   PORTB,1,0
			;	
			;	if(PORTB.5 == 1){ // Port B' nin 5. biti high olmuþsa göstergede 7 göster.
	BTFSS PORTB,5,0
	BRA   m009
			;		PORTD=0x07;
	MOVLW 7
	MOVWF PORTD,0
			;		bekle(300);
	MOVLW 44
	MOVWF t,0
	MOVLW 1
	MOVWF t+1,0
	RCALL bekle
			;		PORTD=0;
	CLRF  PORTD,0
			;	}
			;	if(PORTB.4 == 1){ // Port B' nin 4. biti high olmuþsa göstergede 8 göster.
m009	BTFSS PORTB,4,0
	BRA   m010
			;		PORTD=0x7F;
	MOVLW 127
	MOVWF PORTD,0
			;		bekle(300);
	MOVLW 44
	MOVWF t,0
	MOVLW 1
	MOVWF t+1,0
	RCALL bekle
			;		PORTD=0;
	CLRF  PORTD,0
			;	}
			;	if(PORTB.3 == 1){ // Port B' nin 3. biti high olmuþsa göstergede 9 göster.
m010	BTFSS PORTB,3,0
	BRA   m011
			;		PORTD=0x6F;
	MOVLW 111
	MOVWF PORTD,0
			;		bekle(300);
	MOVLW 44
	MOVWF t,0
	MOVLW 1
	MOVWF t+1,0
	RCALL bekle
			;		PORTD=0;
	CLRF  PORTD,0
			;	}
			;}
			;INTCON=0x90; 
m011	MOVLW 144
	MOVWF INTCON,0
			;goto anadongu;
	BRA   m001
			; // Döngü baþýna dönüþ
			;//-----------------------------------------------	
			;}
			;
			;//////////////////////////////////////////////////////////////////////////////////////////////////
			;
			;void ayarlar()	// Bütün baþlangýç ayarlarýnýn tamamlandýðý kýsým
			;{	
ayarlar
			;	GIE=1;			// Bütün kesmeleri kapat
	BSF   0xFF2,GIE,0
			;	TRISA=0xFF;		// Port A input
	SETF  TRISA,0
			;	TRISB=0xF8;		// Port B' nin 0-3 arasý bitleri output, 4-7 arasý bitleri input 
	MOVLW 248
	MOVWF TRISB,0
			;	TRISC=0;		// Port C output	
	CLRF  TRISC,0
			;	TRISD=0;		// Port D output
	CLRF  TRISD,0
			;	TRISE=0;		// Port E output
	CLRF  TRISE,0
			;
			;	// Program ilk çalýþtýrýldýðýnda çýkýþlarda deðer görülmemesi için ilk çýkýþ deðerleri 0 alýnýr.	
			;	PORTC=0;		
	CLRF  PORTC,0
			;	PORTD=0;
	CLRF  PORTD,0
			;	PORTB=0;
	CLRF  PORTB,0
			;		
			;}
	RETURN
			;
			;void bekle(unsigned long t)	//t milisaniye gecikme saðlar
			;{
bekle
			;	unsigned x;
			;	
			;	for(;t>0;t--)
m012	MOVF  t,W,0
	IORWF t+1,W,0
	BTFSC 0xFD8,Zero_,0
	BRA   m015
			;		for(x=140;x>0;x--)
	MOVLW 140
	MOVWF x,0
m013	MOVF  x,1,0
	BTFSC 0xFD8,Zero_,0
	BRA   m014
			;			nop();
	NOP  
	DECF  x,1,0
	BRA   m013
m014	DECF  t,1,0
	MOVLW 0
	SUBWFB t+1,1,0
	BRA   m012
			;}
m015	RETURN

	END


; *** KEY INFO ***

; 0x0000F8   11 word(s)  0 % : ayarlar
; 0x00010E   17 word(s)  0 % : bekle
; 0x000004    5 word(s)  0 % : kesme
; 0x00000E  117 word(s)  0 % : main

; RAM usage: 3 bytes (3 local), 1533 bytes free
; Maximum call level: 1
; Total of 152 code words (0 %)
