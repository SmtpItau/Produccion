USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LCRRIEPARMDAPON]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LCRRIEPARMDAPON]
   (   @iTag            INTEGER
   ,   @codigo_riesgo   INTEGER   = 0
   ,   @lcrgrumdacod    CHAR(8)   = ''  --paridad moneda
   ,   @lcrpla          FLOAT     = 0.0 --plazo
   ,   @lcrpon          FLOAT     = 0.0 --ponderador
   ,   @Riesgo          CHAR(30)  = ''  --riesgo
   ,   @TBA				varchar(3) = '' --agregado bid/ask
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTag = 0 --retorna los tipos de riesgo
   BEGIN
      SELECT codigo_riesgo, glosa_riesgo FROM RIESGOINTERNO ORDER BY glosa_riesgo
      RETURN
   END

   IF @iTag = 1 --retorna las paridades
   BEGIN
      SELECT LCRGruMdaCod FROM LCRPARMDAGRUMDA ORDER BY LCRGruMdaCod
      RETURN
   END

   IF @iTag = 2 --Retorna datos para tabla
      BEGIN
      SELECT PO.lcrpla, PO.lcrpon, PO.codigo_riesgo, PO.lcrgrumdacod, RI.glosa_riesgo, po.lcrTipoBID_ASK
      FROM   LCRRIEPARMDAPON         PO
             LEFT JOIN RIESGOINTERNO RI ON RI.codigo_riesgo = PO.codigo_riesgo
      WHERE  PO.codigo_riesgo = @codigo_riesgo 
      AND    PO.lcrgrumdacod  = CASE WHEN @lcrgrumdacod = 'TODOS' THEN PO.lcrgrumdacod ELSE @lcrgrumdacod END
      AND    PO.lcrTipoBID_ASK = @TBA
      ORDER BY PO.codigo_riesgo
   END


   IF @iTag = 3 --valida que los datos sean correctos y los ingresa
   BEGIN
   
      SET @codigo_riesgo = (SELECT codigo_riesgo FROM RIESGOINTERNO WHERE glosa_riesgo = @Riesgo)

      IF @lcrpla < 0 
      BEGIN
         SELECT -1, 'Se han detectado plazo negativo' , 'Se aborta la carga del archivo.'
         RETURN
      END
      IF NOT EXISTS(SELECT 1 FROM RIESGOINTERNO WHERE codigo_riesgo = @codigo_riesgo)
      BEGIN
         SELECT -1, 'Items de Riesgo no se encuentra definido' , 'Se aborta la carga del Archivo.'
         RETURN
      END
      IF @lcrgrumdacod <> 'MX'
      BEGIN
         IF NOT EXISTS( SELECT 1 FROM LCRPARMDAGRUMDA WHERE LCRGruMdaCod = @lcrgrumdacod)
         BEGIN
            SELECT -1, 'Par de Monedas no se encuentra definido ' + @lcrgrumdacod, 'Se aborta la carga del archivo.'
            RETURN
         END
      END
	  
      IF EXISTS( SELECT 1 FROM LCRRIEPARMDAPON WHERE codigo_riesgo = @codigo_riesgo AND lcrgrumdacod = @lcrgrumdacod AND lcrpla = @lcrpla AND lcrTipoBID_ASK = @TBA)
      BEGIN
         UPDATE LCRRIEPARMDAPON
            SET lcrpon        = @lcrpon
          WHERE codigo_riesgo = @codigo_riesgo
            AND lcrgrumdacod  = @lcrgrumdacod
            AND lcrpla        = @lcrpla
	    AND lcrTipoBID_ASK = @TBA
      END ELSE
	  
      BEGIN
         INSERT INTO LCRRIEPARMDAPON (codigo_riesgo,  lcrgrumdacod,  lcrpla,  lcrpon, lcrTipoBID_ASK) --@TBA
              VALUES                 (@codigo_riesgo, @lcrgrumdacod, @lcrpla, @lcrpon, @TBA)
      END
   END

   IF @iTag = 4 --elimina todo en la tabla
   BEGIN
      DELETE FROM LCRRIEPARMDAPON
   END

   IF @iTag = 5 --retorna todos los valores
   BEGIN
      DECLARE @nContador NUMERIC(9)
          SET @nContador = (SELECT COUNT(1) FROM LCRRIEPARMDAPON)

      SELECT TBA		= PO.lcrTipoBID_ASK
	 ,   Riesgo     = RI.glosa_riesgo
         ,   Par_Mda    = PO.lcrgrumdacod
         ,   Plazo      = PO.lcrpla   --> CONVERT(NUMERIC(21,8),PO.lcrpla)
         ,   Ponderador = PO.lcrpon   --> CONVERT(NUMERIC(21,8),PO.lcrpon)
         ,   Contador   = @nContador
      FROM   LCRRIEPARMDAPON         PO
             LEFT JOIN RIESGOINTERNO RI ON RI.codigo_riesgo = PO.codigo_riesgo
    --WHERE  PO.codigo_riesgo = @codigo_riesgo 
    --AND    PO.lcrgrumdacod  = CASE WHEN @lcrgrumdacod = 'TODOS' THEN PO.lcrgrumdacod ELSE @lcrgrumdacod END
      ORDER BY PO.codigo_riesgo asc, PO.lcrgrumdacod, PO.lcrTipoBID_ASK asc, po.lcrpla asc
   END

   IF @iTag = 6 --valida los datos que se ingresaron
   BEGIN
      IF EXISTS( SELECT 1 FROM BacParamSuda..PRODUCTO WHERE riesgo_interno > 0
                                                        AND riesgo_interno NOT IN( SELECT DISTINCT codigo_riesgo FROM LCRRIEPARMDAPON WHERE lcrgrumdacod = 'MX' ) )
      BEGIN
         SELECT -1, 'Falta Ponderador MX para riesgo asociado a un producto.', ''
         RETURN
      END

      DECLARE @ContOrig   NUMERIC(9)
      DECLARE @ContVali   NUMERIC(9)

          SET @ContOrig   = (SELECT COUNT(1) FROM RIESGOINTERNO)
          SET @ContVali   = (SELECT COUNT( DISTINCT Pond.codigo_riesgo) 
                               FROM LCRRIEPARMDAPON          Pond
                                    INNER JOIN RIESGOINTERNO Rigo ON Rigo.codigo_riesgo = Pond.codigo_riesgo 
                              WHERE Pond.lcrgrumdacod  <> 'MX')
                              
      IF @ContOrig > @ContVali
      BEGIN
         SELECT -1, 'Items de Riesgos Faltante... No viene definido en la planilla.', 'Imposible conformar una semantica.'
         RETURN
      END

          SET @ContOrig   = (SELECT COUNT(1) FROM LCRPARMDAGRUMDA)
          SET @ContVali   = (SELECT COUNT( DISTINCT Pond.lcrgrumdacod )
                               FROM LCRRIEPARMDAPON            Pond
                                    INNER JOIN LCRPARMDAGRUMDA Parm ON Parm.LCRGruMdaCod = Pond.lcrgrumdacod
                              WHERE Pond.lcrgrumdacod  <> 'MX')

      IF @ContOrig > @ContVali
      BEGIN
         SELECT -1, 'Par de Moneda Faltante... No viene definido en la planilla.', 'Imposible conformar una semantica.'
         RETURN   
      END

   END

   IF @iTag = 7 --recupera los tipos bid o ask
   BEGIN
		SELECT TGD.tbglosa  
		FROM BacParamSuda..TABLA_GENERAL_DETALLE TGD 
		WHERE TGD.tbcateg = 9909 
   END

END
GO
