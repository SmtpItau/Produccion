USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LLENA_FLUJO_CARTERA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LLENA_FLUJO_CARTERA] (
                                              @CRUT    CHAR(10)                               --  2
                                             ,@CREF    CHAR(23)                               --  3
                                             ,@NCOPE   char(20)                               --  4
                                             ,@NCSUP   NUMERIC(10)                             --  5 FALTA
                                             ,@NCTAS   CHAR(3)                                --  6
                                             ,@NSCTA   CHAR(2)                                --  7
                                             ,@NCALI   CHAR(1)                                --  8
                                             ,@NTIPC   CHAR(4)                                --  9
                                             ,@NCPRO   NUMERIC(3)                             -- 10
                                             ,@CTCAR   CHAR(3)                                -- 11
                                             ,@NTCRE   CHAR(2)                                -- 12
                                             ,@DFOTO   DATETIME                               -- 13
                                             ,@NVORI   NUMERIC(19,4)                          -- 14
                                             ,@NCUPO   NUMERIC(15)                            -- 15
                                             ,@NVATC   NUMERIC(19,4)                          -- 16
                                             ,@CCMON   char(2)                                -- 17
                                             ,@CCMOR   char(3)                                -- 18
                                             ,@NMONE   NUMERIC(3)                             -- 19
                                             ,@NBASE   CHAR(3)--NUMERIC(3)                             -- 20
                                             ,@NTASA1  NUMERIC(19,4)                          -- 21
                                             ,@CTTAS   CHAR(3)                                -- 22
                                             ,@NTCOM   numeric(19,4) --CHAR(6)                                -- 23
                                             ,@NTCOF   CHAR(6)                                -- 24
                                             ,@DFEXT   DATETIME                               -- 25
                                             ,@DFVEN   DATETIME                               -- 26
                                             ,@NCAPOI  NUMERIC(15)                            -- 27
                                             ,@NPCRB   CHAR(3)                                -- 28
                                             ,@NPZOP   NUMERIC(6)                             -- 29
                                             ,@NNCUA   CHAR(3)                                -- 30
                                             ,@NMCUA   CHAR(16)                               -- 31
                                             ,@NMATR   CHAR(2)                                -- 32
                                             ,@NISIS   CHAR(3)                                -- 33
                                             ,@NOFIO   CHAR(5)                                -- 34
                                             ,@NOFCO   CHAR(5)                                -- 35
                                             ,@NCEJE   CHAR(3)                                -- 36
                                             ,@NCCOS   CHAR(5)                                -- 37
                                             ,@DFTAS   DATETIME                               -- 38
                                             ,@NNTO1   numeric(3)                                -- 39
                                             ,@NNCUP   numeric(5)  -- 40
                                             ,@NCOPI   CHAR(20) -- 41
                                             ,@NINTEL  NUMERIC(19,4)   -- 42
                                             ,@NCOPR   CHAR(20)                               -- 43
                                             ,@NREAJ   NUMERIC(19,4)                          -- 44
                                             ,@CCJUD   CHAR(1)                                -- 45
                                             ,@CINFO   CHAR(1)                                -- 46
                                             ,@CRELL   numeric(5)                             -- 47
                                             ,@sw      numeric(1)
                                             )

AS
BEGIN 
SET NOCOUNT ON


if @sw = 1
DELETE TABLA_INTERFAZ  --WHERE DESCR = 1


set @NVATC  = @NVATC  / 10000
set @NTASA1 = @NTASA1 / 10000
INSERT TABLA_INTERFAZ VALUES( '2', @CRUT    ,@CREF    ,@NCOPE   ,@NCSUP   ,@NCTAS   ,@NSCTA   ,@NCALI 
                                  ,@NTIPC   ,@NCPRO   ,@CTCAR   ,@NTCRE   ,@DFOTO   ,@NVORI   ,@NCUPO   
                                  ,@NVATC   ,@CCMON   ,@CCMOR   ,@NMONE   ,@NBASE   ,@NTASA1  ,@CTTAS   
                                  ,@NTCOM   ,@NTCOF   ,@DFEXT   ,@DFVEN   ,@NCAPOI  ,@NPCRB   ,@NPZOP   
                                  ,@NNCUA   ,@NMCUA   ,@NMATR   ,@NISIS   ,@NOFIO   ,@NOFCO   ,@NCEJE   
                                  ,@NCCOS   ,@DFTAS   ,@NNTO1   ,@NNCUP   ,@NCOPI   ,@NINTEL  ,@NCOPR   
                                  ,@NREAJ   ,@CCJUD   ,@CINFO   ,@CRELL   ,1
                              ) 


end 

-- select * from MDCP WHERE CPCODIGO<>20
-- SELECT * FROM CARTERA_CUENTA WHERE CodigoInst <> 20

GO
