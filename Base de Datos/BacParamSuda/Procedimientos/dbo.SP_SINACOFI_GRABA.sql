USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SINACOFI_GRABA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_SINACOFI_GRABA]
            (  
                  @clrut         NUMERIC(10) ,
                  @clcodigo      NUMERIC(10) ,
                  @clnumsinacofi CHAR(4)     ,
                  @clnomsinacofi CHAR(4)     ,
                  @datatec       CHAR(10)    ,
                  @bolsa         CHAR(10)    ,
		  @clnombre      CHAR(70)='',
--                @standard         CHAR(10)   ,
--                @barclays         CHAR(10)   ,
--                @citibank         CHAR(10)
                  @SourceBac CHAR(3),
                  @BankDealinkCoded VARCHAR(20),
                  @Terminal VARCHAR(20),
                  @System VARCHAR(20),
                  @SOfData INT,
                  @CodigoSwifth VARCHAR(20),
                  @PlataformaExterna BIT
            )
AS 
BEGIN
   SET NOCOUNT ON
   
   IF NOT EXISTS(SELECT 1 FROM SINACOFI WHERE clrut = @clrut and clcodigo = @clcodigo )
   BEGIN 
      INSERT INTO SINACOFI( clrut
                           ,clcodigo
                           ,clnumsinacofi
                           ,clnomsinacofi
                           ,datatec
                           ,bolsa
			   ,nombredata
--                         ,standardChartered
--                         ,barclays
--                         ,citibank
                           ,SourceBac
                           ,BankDealinkCoded
                           ,Terminal
                           ,System
                           ,SOfData
			               ,CodigoSwifth
                           ,PlataformaExterna
                          )
                    VALUES( @clrut
                           ,@clcodigo
                           ,@clnumsinacofi
                           ,@clnomsinacofi
                           ,@datatec
                           ,@bolsa
			   ,@clnombre
--                         ,@standard
--                         ,@barclays
--                         ,@citibank
                           ,@SourceBac
                           ,@BankDealinkCoded
                           ,@Terminal
                           ,@System
                           ,@SOfData
                           ,@CodigoSwifth
                           ,@PlataformaExterna


                          )
   END ELSE BEGIN
        UPDATE SINACOFI SET clrut         = @clrut
                           ,clcodigo      = @clcodigo
                           ,clnumsinacofi = @clnumsinacofi
                           ,clnomsinacofi = @clnomsinacofi
                           ,datatec       = @datatec
                           ,bolsa         = @bolsa
			   ,nombredata    = @clnombre
--                         ,standardChartered = @standard
--                         ,barclays = @barclays
--                         ,citibank = @citibank
                           ,SourceBac         = @SourceBac
                           ,BankDealinkCoded  = @BankDealinkCoded
                           ,Terminal          = @Terminal
			               ,System            = @System
                           ,SOfData           = @SOfData
                           ,CodigoSwifth      = @CodigoSwifth
                           ,PlataformaExterna = @PlataformaExterna
                        WHERE clrut = @clrut and clcodigo = @clcodigo
   END
   SET NOCOUNT OFF
END
GO
