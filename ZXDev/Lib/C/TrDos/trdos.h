/* * * * * * * * * * * * * * * * * * * * * * * */
/* ������� � �������� TR-DOS ��� SDCC  		   */
/* ��������� ��� ��������������� ������������� */
/* SDCC interface for TR-DOS functions         */
/* Absolutely free for noncommercial use	   */
/* (c) 2013 Amxgris/Red Triangle/Mother Russia */
/* * * * * * * * * * * * * * * * * * * * * * * */

#define TR_DOS_H   1
// ��� ������ �� ������ ������, - � ���� "������" ���� ��������
#define trdosFileOperationSign 0x5CF9
#define trdosFileLoadVerifySign 0x5d10
#define trdosFileName 0x5cdd
#define trdosCheckSymbolsNum 0x5d06
#define trdosDeletedFilesNum 0x5d07
#define trdosErrorCode 0x5d0f
#define trdosFoundFileNum 0x5d1e

// ��������� ���������� ����� TR-DOS:
struct trdosFDSP {
			 char  trFName[9]; // ��� � ��� �����
	unsigned char *trFStart;   // ��. �������� TR-DOS
	unsigned int   trFByteLen;
	unsigned char  trFSectLen;
	unsigned char  trFSector;
	unsigned char  trFTrack;};

// ��������� �������:	
	
// ������� #01 TR-DOS:
// 				 drive name ('a','b','c','d'), �� ������������� � ��������
void trdosDriveSel(char); 

// ������� #00 TR-DOS:
void trdosInit(void);

// ������� #18 TR-DOS:
void trdosDiskTune(void);

// ������� #05 TR-DOS:
// 						destptr, 	  track pos, 	 sector pos,    len in sectors
void trdosReadSectors(unsigned char*, unsigned char, unsigned char, unsigned char);

// ������� #08 TR-DOS:
// 					  destptr, 	       file number
void trdosReadFileDSP(unsigned char *, unsigned char);

// ������� #06 TR-DOS:
// 						srctptr, 	  track pos, 	 sector pos,    len in sectors
void trdosWriteSectors(unsigned char*, unsigned char, unsigned char, unsigned char);

// ������� #09 TR-DOS:
// 					   srctptr, 	    file number
void trdosWriteFileDSP(unsigned char *, unsigned char);

// ������� #0A TR-DOS:
//							name ptr  name len
unsigned char trdosFindFile(char *, unsigned char);

// ������� #0B TR-DOS:
//					name ptr	data ptr		 file data len
void trdosWriteFile(char *,		unsigned char *, unsigned int);

// ������� #12 TR-DOS:
//					FDSP ptr
void trdosEraseFile(char *);
// ������� #0E TR-DOS, (23801) = 0:
//					name ptr	dest ptr	  file data len
void trdosLoadFile	(char *, unsigned char *, unsigned int);
