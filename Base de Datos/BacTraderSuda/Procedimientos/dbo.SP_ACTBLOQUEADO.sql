USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTBLOQUEADO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ACTBLOQUEADO]
   (   @bpnumdocu	NUMERIC(10,0)	
   ,   @bpcorrela	NUMERIC(3,0)	
   ,   @bpnominal       NUMERIC(19,4)	
   ,   @CorteMinimo     NUMERIC(19,4)	
   ,   @Nominal		NUMERIC(19,4)
   ,   @NominalTotal    NUMERIC(19,4)
   ,   @Usuario         CHAR(15)
   ,   @Sistema         CHAR(15)	
   ,   @Producto        CHAR(15)
   ,   @CarteraF        CHAR(10)
   ,   @CarteraN        CHAR(10)
   )
AS
BEGIN

   SET NOCOUNT ON 
   DECLARE @Bloqueado     NUMERIC(19,4)
   DECLARE @HayRegistro   INT
  
   SET @Bloqueado   = 0
   SET @HayRegistro = 0
    
   SELECT @Bloqueado   = bpnominal
   ,      @HayRegistro = 1
   FROM   bloqueadopacto -- bloqueadop 
   WHERE  bpnumdocu    = @bpnumdocu
   AND    bpcorrela    = @bpcorrela
  

   IF @bpnominal < @CorteMinimo and @bpnominal > 0
   BEGIN
	SELECT -1, 'Bloqueo debe ser mayor a Corte Minimo,',@bpnumdocu,@bpcorrela
	RETURN 
   END
     
   IF (CAST(@bpnominal/ISNULL(NULLIF(@CorteMinimo,0),1)AS FLOAT) - (FLOOR(@bpnominal/ISNULL(NULLIF(@CorteMinimo,0),1))))<> 0
       AND @CorteMinimo > 0
   BEGIN 
	SELECT -1, 'Nominal Bloqueado debe ser multiplo de Corte Minimo,',@bpnumdocu,@bpcorrela
	RETURN
   END
/*
   IF  @CorteMinimo = 0 AND  @bpnominal > 0 AND (@Nominal+@bpnominal) <> @bpnominal
   BEGIN 
       	SELECT -1, 'Los papeles sin corte minimo se bloquean completos,',@bpnumdocu,@bpcorrela
        RETURN
   END
*/
   IF @Nominal < 0 
   BEGIN
        SELECT -1, 'Nominal no debe ser negativo revizar,',@bpnumdocu,@bpcorrela
        RETURN
   END 
   
   IF  @bpnominal < 0 
   BEGIN
        SELECT -1, 'Bloqueo no debe ser negativo revizar,',@bpnumdocu,@bpcorrela
        RETURN
   END 


      
   DECLARE @Tdinominal NUMERIC(19,4) 
   DECLARE @Entra INT
   

-- Variables no inicializadas antes de la busqueda
-- podrías quedar ocn valor null

   Set @Tdinominal = 0 
   Set @Entra      = 0 

   -- Con la variable @Entra yo sabre si existe o no
   -- y el monto se rescata en la variable @dinominalMDDI
   SELECT @Tdinominal = A.DiNominal + isnull( B.ViNominal , 0 )
   ,      @Entra = 1
   FROM   MDDI A
          LEFT JOIN MDVI B on  A.DiNumDocu = B.ViNumDocu AND  A.DiCorrela = B.ViCorrela  
   WHERE  A.dinumdocu = @bpnumdocu 
   AND 	  A.dicorrela = @bpcorrela

-- Cualquier expresion boleana que tenga null evalua todo falso
   IF @Entra = 1 AND @Tdinominal <> @NominalTotal
   BEGIN 
       	SELECT -1, 'Disponibilidad de Nominal Total a variado en su monto,',@bpnumdocu,@bpcorrela 
	RETURN
   END

   DECLARE @Existe INT
   SET     @Existe =0

   SELECT  @Existe = 1
   FROM    MDDI  
   WHERE   dinumdocu = @bpnumdocu 
   AND 	   dicorrela = @bpcorrela

   IF @Existe = 0 
   BEGIN 
       	SELECT -1, 'No existe N° de compra Correlativo en BD,',@bpnumdocu,@bpcorrela 
	RETURN
   END


   IF (@Nominal+@bpnominal)<> @NominalTotal
   BEGIN
        SELECT -1,'Nominal + Bloqueo deben ser igual a Total Nominal,',@bpnumdocu,@bpcorrela 
        RETURN
   END

-- Comentado, por Documento solo se 
-- chequean la cartera financiera
/*
   DECLARE @EXISCARTN AS  INT
   SET @EXISCARTN = 0

   SELECT @EXISCARTN = 1
   FROM  BACPARAMSUDA..TBL_REL_USUARIO_NORMATIVO
   WHERE Ucn_Usuario =  @Usuario
   AND   Ucn_Sistema =  @Sistema
   AND   Ucn_Producto = @Producto
   AND   Ucn_Codigo_CartN = @CarteraN 

   IF  @EXISCARTN = 0
   BEGIN SELECT -1, 'Usuario no esta autorizado a Bloquear Cartera Normativa',@bpnumdocu,@bpcorrela
   RETURN
   END
*/
   DECLARE @EXISCARTF AS  CHAR
   SET @EXISCARTF = 0

   SELECT @EXISCARTF = 1
  
   FROM  BACPARAMSUDA..TBL_REL_USU_CART_FINANCIERA
   WHERE Ucf_Usuario =  @Usuario
   AND   Ucf_Sistema =  @Sistema
   AND   Ucf_Producto = @Producto
   AND   Ucf_Codigo_Cart = @CarteraF

   IF  @EXISCARTF = 0
   BEGIN 
        SELECT -1, 'Usuario no esta autorizado a Bloquear Cartera Financiera',@bpnumdocu,@bpcorrela
        RETURN
   END

IF @Bloqueado <> @bpnominal
   BEGIN --PRINT 'DATO MODIFICADO'
	 --PRINT @HayRegistro
      	 DELETE FROM  bloqueadopacto -- bloqueadop
         WHERE       bpnumdocu     = @bpnumdocu
         AND  	     bpcorrela     = @bpcorrela  
       
         IF  (@bpnominal <> 0) 
	 BEGIN
           INSERT INTO  bloqueadopacto -- bloqueadop
           (      bpnumdocu
           ,      bpcorrela
           ,      bpnominal
           )
           VALUES 
           (      @bpnumdocu	
           ,      @bpcorrela
           ,      @bpnominal
           )
	   --PRINT 'AAAAAAAA'
         END
    END
      ELSE
      IF @Bloqueado = @bpnominal 
      BEGIN 
           PRINT  'DATO NO MODIFICADO'
      END
END

GO
