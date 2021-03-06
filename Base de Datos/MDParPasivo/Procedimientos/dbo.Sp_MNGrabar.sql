USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MNGrabar]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_MNGrabar]
   (   @mncodmon1      NUMERIC (3,0)
   ,   @mnnemo1        CHAR    (05)
   ,   @mnsimbol1      CHAR    (05)
   ,   @mndescrip1     CHAR    (30)
   ,   @mnredondeo1    NUMERIC (2,0)
   ,   @mnbase1        NUMERIC (3,0)
   ,   @mntipmon1      CHAR    (01)
   ,   @mnperiodo1     NUMERIC (2,0)
   ,   @mncodsuper1    NUMERIC (3,0)
   ,   @mncodfox       CHAR    (  6)
   ,   @mncodcor       NUMERIC (  7)
   ,   @mncodbcch      NUMERIC (5,0)
   ,   @mncodpais      NUMERIC (3,0)
   ,   @mone           NUMERIC (1,0)
   ,   @refmerc        NUMERIC (1,0)
   ,   @refusd	       NUMERIC (1,0)
   ,   @MonedaLocal    NUMERIC (1,0)
   ,   @codigo_canasta NUMERIC(5)
   ,   @valFox         NUMERIC(1)
   ,   @ocurrencia     NUMERIC(2) 
   ,   @Cod_div_esp    NUMERIC(2) --05/11/2004 Jspp Campo para interfaz a España
   )
AS
BEGIN

SET NOCOUNT ON
SET DATEFORMAT dmy

   DECLARE @mnmx CHAR(1)
         , @Codigo_Variablidad CHAR(3)

   SELECT @Codigo_Variablidad = 999

   SELECT @mnmx = (CASE WHEN @mntipmon1 = '3' THEN 'C' ELSE '' END)

   SELECT @refusd = ( CASE WHEN @refusd = 1 THEN 0 ELSE 1 END )
	
   IF @mncodsuper1 <> 0 BEGIN
   	IF EXISTS(SELECT mncodsuper FROM MONEDA WHERE mncodmon <> @mncodmon1 AND mncodsuper = @mncodsuper1)
   	BEGIN
   	   SELECT -1, 'Código Super Ya Existe ...','13010'
   	   SET NOCOUNT OFF
   	   RETURN
   	END
   END

   IF @mncodbcch <> 0 BEGIN
       IF EXISTS(SELECT mncodbanco FROM MONEDA WHERE mncodmon <> @mncodmon1 AND mncodbanco = @mncodbcch)
       BEGIN
            SELECT -1, 'Código Banco Central Ya Existe ','13020'
   	    SET NOCOUNT OFF
            RETURN
       END    
   END

       IF EXISTS(SELECT mncodmon FROM MONEDA WHERE mncodmon = @mncodmon1 AND ESTADO='A' )
       BEGIN
            SELECT -1, 'Moneda Ya Fue Utilizada Anteriormente ','13020'
   	    SET NOCOUNT OFF
            RETURN
       END    

      --06/11/2004 Jspp Campo para interfaz a España
      --IF EXISTS(SELECT CodDivEsp FROM MONEDA WHERE CodDivEsp = @Cod_div_esp AND CodDivEsp<>0 )
      -- BEGIN
      --      SELECT -1, 'Codigo Divisa España Ya Fue Utilizado Anteriormente ','13020'
      --	    SET NOCOUNT OFF
      --      RETURN
      -- END    

       IF EXISTS(SELECT mncodmon FROM MONEDA WHERE mncodmon = @mncodmon1 )
                     UPDATE  MONEDA 
                     SET     mncodmon        = @mncodmon1
                     ,       mnnemo          = @mnnemo1
                     ,       mnsimbol        = @mnsimbol1
                     ,       mnglosa         = @mndescrip1
                     ,       mnredondeo      = @mnredondeo1
                     ,       mnbase          = @mnbase1
                     ,       mntipmon        = @mntipmon1
                     ,       mnperiodo       = @mnperiodo1
                     ,       mncodsuper      = @mncodsuper1
                     ,       mncodfox        = @mncodfox
                     ,       mncodcor        = @mncodcor
                     ,       mncodbanco      = @mncodbcch
                     ,       mnmx            = @mnmx
        	     ,	     codigo_pais     = @mncodpais
                     ,       mnextranj       = @mone
                     ,       mnrefusd        = @refusd
                     ,       mnnemsuper      = ''
                     ,       mnnembanco      = ''
                     ,       mndecimal       = 0
--                     ,       mncodpais       = 0
                     ,       mnfactor        = 0
                     ,       mnlocal         = @MonedaLocal
--                     ,       mningval        = 0
                     ,       mnvalor         = 0
                     ,       mnrefmerc       = @refmerc
                     ,       mnvalfox        = @valFox
--                     ,       mniso_coddes    = 'C'
                     ,       mnrrda          = CASE WHEN @refusd = 1 THEN 'D' ELSE '' END
                     ,       codigo_canasta  = @codigo_canasta
                     ,       codigo_variabilidad  = @Codigo_Variablidad 
                     ,       ocurrencia        = @ocurrencia
		     ,	     CodDivEsp	       = @Cod_div_esp --05/11/2004 Jspp Campo para interfaz a España
                    WHERE    mncodmon        = @mncodmon1
 
      ELSE

          INSERT INTO MONEDA
               (   mncodmon
                ,  mnnemo
                ,  mnsimbol
                ,  mnglosa
                ,  mnredondeo
                ,  mnbase
                ,  mntipmon
                ,  mnperiodo
                ,  mncodsuper
                ,  mncodfox
                ,  mncodcor
                ,  mncodbanco
                ,  codigo_pais
                ,  mnmx
                ,  mnextranj
                ,  mnrefmerc
                ,  mnrefusd
                ,  mnnemsuper
                ,  mnnembanco
                ,  mndecimal
--                ,  mncodpais
                ,  mnfactor
                ,  mnlocal
--                , mningval
                ,  mnvalor
                ,  mnvalfox
--                ,  mniso_coddes
                ,  mnrrda
                ,  codigo_canasta   
                ,  codigo_variabilidad 
                ,  ocurrencia
		,  CodDivEsp --05/11/2004 Jspp Campo para interfaz a España
               )
      	   VALUES 
               (   @mncodmon1
                ,  @mnnemo1
                ,  @mnsimbol1
                ,  @mndescrip1
                ,  @mnredondeo1
                ,  @mnbase1
                ,  @mntipmon1
                ,  @mnperiodo1
                ,  @mncodsuper1
                ,  @mncodfox
                ,  @mncodcor
                ,  @mncodbcch
                ,  @mncodpais
                ,  @mnmx
                ,  @mone
                ,  @refmerc
		,  @refusd
		,  ''
		,  ''
		,  0
--		,  0
		,  0
		,  @MonedaLocal
--		,  0
		,  0
		,  @valFox
--		,  'C'
		,  CASE WHEN @refusd = 1 THEN 'D' ELSE '' END
                ,  @codigo_canasta   
                ,  @Codigo_Variablidad 
                ,  @ocurrencia
		,  @Cod_div_esp --05/11/2004 Jspp Campo para interfaz a España
               )

	 	    SELECT 0 , 'Información Grabada en Forma Correcta' , ''

   SET NOCOUNT OFF

   RETURN

END









GO
