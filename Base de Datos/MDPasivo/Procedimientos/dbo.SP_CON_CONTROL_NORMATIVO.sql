USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CONTROL_NORMATIVO]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_CON_CONTROL_NORMATIVO](@cSistema         CHAR(3),	
                                         @cProducto        CHAR(5),
                                         @nnumoper         NUMERIC(10),
                                         @nRut_entidad     NUMERIC(10),
                                         @nDias_Pacto_Bcch NUMERIC(3) ,
                                         @nRut_Bcch        NUMERIC(10),
                                         @nPlaza           NUMERIC(05),
                                         @nPais            NUMERIC(05),
                                         @ccodigo_Grupo    CHAR(15),
			  		 @tasa		   FLOAT = 0
                                        )   
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON	
        SET DATEFORMAT dmy

        DECLARE @ncorrelativo        NUMERIC(10),
                @ndocumento          NUMERIC(10),
                @nEmisor             NUMERIC(10),
                @nPlazo              NUMERIC(10),
                @nForma_Pago         NUMERIC(10),
                @cEstado             CHAR(1),
                @ncodigo             NUMERIC(5),
                @nRut_Cliente        NUMERIC(10),
                @nCodigo_Cliente     NUMERIC(10),
                @dFecha_inicio       DATETIME,
                @dFecha_Vcto_operacion DATETIME,
                @dFecha_Vcto_papel   DATETIME,
                @oResultado          VARCHAR(100),
                @nContador           NUMERIC(5),
		@DiasParamGene	     NUMERIC(5)
			

        CREATE TABLE #MENSAJE(mensaje VARCHAR(100))

        SELECT @ncorrelativo = 0 ,
               @cestado   = 'S'
    
        SELECT @cestado            ='S'  ,       
               @ncorrelativo       = -1 ,
               @ncontador          = 0


        WHILE @cestado = 'S'
        BEGIN
		
               SELECT @cestado = 'N',@ncontador = @ncontador + 1
               SELECT @nEmisor                = Rut_Emisor,
                      @nPlazo                 = DATEDIFF(d,FechaOperacion,FechaVencimiento),
                      @nRut_Cliente           = Rut_Cliente,
                      @nCodigo_Cliente        = Codigo_Cliente,
                      @dFecha_inicio          = FechaOperacion,
                      @dFecha_Vcto_operacion  = FechaVencimiento,
                      @dFecha_Vcto_papel      = FechaVctoInst,
                      @cestado                = 'S',
                      @nCodigo                = incodigo,
                      @ncorrelativo           = NumeroCorrelativo,
                      @ndocumento             = Numerodocumento,
                      @nForma_Pago            = FormaPago

               FROM   LINEA_CHEQUEAR WITH (NOLOCK)
               WHERE  Id_Sistema = @csistema
               AND    codigo_producto = @cproducto
               AND    NumeroOperacion = @nnumoper
               AND    NumeroCorrelativo > @ncorrelativo
               ORDER BY  NumeroCorrelativo

-- select * from LINEA_CHEQUEAR


            /***********************************************************************************************************/
               DECLARE @iTipo_Cliente INTEGER
               DECLARE @cTipo_Cliente CHAR(40)

               SET @iTipo_Cliente = ISNULL((SELECT cltipcli FROM CLIENTE  WITH (NOLOCK) WHERE clrut = @nRut_Cliente AND clcodigo = @nCodigo_Cliente),0)
               SET @cTipo_Cliente = ISNULL((SELECT descripcion FROM TIPO_CLIENTE  WITH (NOLOCK) WHERE codigo_tipo_cliente = @iTipo_Cliente),'DESCONOCIDO')

               IF @nForma_Pago = 1 AND @iTipo_Cliente <> 1 BEGIN
                    INSERT INTO #MENSAJE VALUES('No se puede emitir VALE CAMARA para tipo de cliente ' + LTRIM(RTRIM(@cTipo_Cliente)))
               END 
            /***********************************************************************************************************/
----------- FFMM	
	    	IF @cproducto in ('CFM') AND @cSistema = 'BTR' AND  @ncontador = 1 BEGIN
			SELECT @DiasParamGene=FFMMDiasMaximo FROM DATOS_GENERALES
			IF(@nPlazo>@DiasParamGene)BEGIN
		                 INSERT INTO #MENSAJE VALUES('No se Pueden Realizar Operaciones porque se Excedió en los días máximos permitidos')
			END
		END
----------- 
               IF @nemisor =  @nRut_entidad AND @ncodigo = 15 AND @cproducto = 'CI' AND @cSistema = 'BTR' BEGIN
                 INSERT INTO #MENSAJE VALUES('No puede Comprar con Pacto BONOS de Propia Emisión')
               END         
-----------
               IF  @nPlazo < @nDias_Pacto_Bcch and @nemisor <> @nRut_Bcch AND @cproducto = 'VI' AND @cSistema = 'BTR' BEGIN
                    INSERT INTO #MENSAJE VALUES('Pacto contiene papeles que no son emitidos por el Banco Central con Plazo de Pacto menor a : ' + convert(char(5),@nDias_Pacto_Bcch ) )
               END         
-----------
               IF  @dFecha_Vcto_papel < @dFecha_Vcto_operacion  AND @cproducto = 'VI' AND @cSistema = 'BTR' BEGIN
                    INSERT INTO #MENSAJE VALUES('Documento Nº ' + CONVERT(CHAR(10),@ndocumento) +  ' - ' + CONVERT(CHAR(10),@ncorrelativo) + ' No Disponible a la Fecha Vcto. Venta Pacto.')
               END         
-----------
               IF @cproducto in ('VI','RCA') AND @cSistema = 'BTR' AND @ncontador = 1 BEGIN -- se quita control a RVA por petición del banco
        	        EXEC SP_TOTDIASHABILES @nRut_cliente,@nCodigo_Cliente,@dFecha_inicio,@dFecha_vcto_operacion,@nPlaza,@nPais, @oResultado OUTPUT

/*                  IF @cproducto in ('RCA') and @oresultado <> 'OK' and @tasa <> 0 BEGIN -- se quita control a RVA por petición del banco
                      INSERT INTO #MENSAJE VALUES('No se Pueden Realizar Operaciones con el Cliente por menos de 4 Días Hábiles')
		  END	
*/
                  IF  @oResultado <> 'OK'  and @cproducto = 'VI' BEGIN
                       INSERT INTO #MENSAJE VALUES('No se Pueden Realizar Operaciones con el Cliente por menos de 4 Días Hábiles')
                  END

               END
-----------
        END
    
        SELECT DISTINCT mensaje FROM #MENSAJE ORDER BY mensaje

END

GO
