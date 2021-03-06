USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAROPERACION_VERIF]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GRABAROPERACION_VERIF]  

   (

       @Modulo_BAC               VARCHAR(3)      

   ,   @Tipo_Validacion          VARCHAR(17)  -- RESTRICCIONES_AOP 

                                              -- RESTRICCIONES_TEC  

   ,   @nnumoper                 NUMERIC(10)  

   ,   @ncodcart                 NUMERIC(09)  

   ,   @ncodigo                  NUMERIC(09)  

   ,   @ncodpos1                 NUMERIC(02)  

   ,   @ncodmon1                 NUMERIC(03)  

   ,   @ncodmon2                 NUMERIC(03)  

   ,   @ctipoper                 CHAR(1)  

   ,   @ctipmoda                 CHAR(1)  

   ,   @dfecha                   DATETIME  

   ,   @ntipcam                  FLOAT  

   ,   @nmdausd                  NUMERIC(03,0)  

   ,   @nmtomon1               NUMERIC(21,4) --> 12  

   ,   @nequusd1                 NUMERIC(21,4) --> 13            

   ,   @nequmol1                 NUMERIC(21,4) --> 14  

   ,   @nmtomon2               NUMERIC(21,4) --> 15  

   ,   @nequusd2                 NUMERIC(21,4) --> 16  

   ,   @nequmol2                 NUMERIC(21,4) --> 17  

   ,   @nparmon1                FLOAT         --> 18  

   ,   @npremon1                 FLOAT         --> 19  

   ,   @nparmon2                 FLOAT         --> 20  

   ,   @npremon2                 FLOAT         --> 21  

   ,   @cestado                  CHAR(1)  

   ,   @cretiro                  CHAR(1)  

   ,   @ccontraparte             NUMERIC(09)  

   ,   @cobserv                  VARCHAR(255)  

   ,   @nspread                  FLOAT  

   ,   @nprecal                  FLOAT         --> 27  

   ,   @nplazo                   NUMERIC(06)   --> 28  

   ,   @cfecvcto                 DATETIME      --> 29  

   ,   @clock                    CHAR(15)  

   ,   @coperador                CHAR(15)  

   ,   @ntasausd                 FLOAT  

   ,   @ntasacon                 FLOAT  

   ,   @nfpagomn                 NUMERIC(03)  

   ,   @nfpagomx                 NUMERIC(03)  

   ,   @nMtoMon1ini              NUMERIC(21,4) --> 36  

   ,   @nMtoMon1fin              NUMERIC(21,4) --> 37  

   ,   @nMtoMon2ini             NUMERIC(21,4) --> 38  

   ,   @nMtoMon2fin            NUMERIC(21,4) --> 39  

   ,   @nentidad                 NUMERIC(05,0)  

   ,   @ncodcli                  NUMERIC(09)  -- Codigo Cliente @ncodigo @ncodcli

   ,   @nMtoDif                  NUMERIC(19,0)  

   ,   @nBroker                  NUMERIC(09,0)  

   ,   @nMontoPFE              NUMERIC(24,1)  = 0  

   ,   @nMontoCCE             NUMERIC(24,1)  = 0  

       --------------------------  

   ,   @id_sistema               CHAR(03)       = ''  

   ,   @Precio_Transferencia     NUMERIC(21,11) = 00  

   ,   @Tipo_Sintetico           CHAR(03)       = ''  

   ,   @Precio_Spot              NUMERIC(10,4)  = 00  

   ,   @Pais_Origen              NUMERIC(05,00) = 00  

   ,   @Moneda_Compensacion      NUMERIC(05,00) = 00  

   ,   @Riesgo_Sintetico         CHAR(03)       = ''  

   ,   @Precio_Reversa_Sintetico NUMERIC(10,04) = 00  

   ,   @npremio                  NUMERIC(21,4)  

   ,   @ctipopc                  CHAR(01)  

   ,   @precio_punta             FLOAT  

   ,   @remunera_linea           NUMERIC(10,04)  

   ,   @tasa_efectiva_moneda1    FLOAT  

   ,   @tasa_efectiva_moneda2    FLOAT  

   ,   @relacionada_spot         CHAR(2)  

   ,   @tasaefectmon1            FLOAT          = 0.0  

   ,   @tasaefectmon2            FLOAT          = 0.0  

   ,   @ntipcamSpot              FLOAT          = 0.0  

   ,   @ntipcamFwd               FLOAT          = 0.0  

   ,   @dfechaefect              DATETIME       = @cfecvcto  

   ,   @Serie                    VARCHAR(12)    = ''  

   ,   @Seriado                  CHAR(1)        = ''  

   ,   @ntipcamPtosFwd           FLOAT          = 0.0  

   ,   @CodAreaResponsable  CHAR(06)       = ''  --Area responsable

   ,   @CodCartNorm   CHAR(06)       = ''		 --Cartera Normativa

   ,   @CodSubCartNorm   CHAR(06) = ''     --Subcartera

   ,   @CodLibro CHAR(06)       = ''			 --Libro

   ,   @estadoSina   CHAR(25)       = ''  

   ,   @fechaSina                DATETIME       = ''  

  

   --> MX-$  

   ,   @nCostoUSDCLP             FLOAT          = 0.0  

   ,   @nCostoMxUSD              FLOAT          = 0.0  

   ,   @nCostoMxCLP              FLOAT          = 0.0  

   ,   @iRefTc                   INT        = 0.0  

   ,   @iRefParidad				 INT  = 0.0  

   ,   @dRefTc                   DATETIME       = ''  

   ,   @dRefParidad              DATETIME       = ''  

   ,   @nTipCamUSDCLP            FLOAT          = 0.0  

   ,   @nSpotTc                  FLOAT          = 0.0  

   ,   @nSpotParidad             FLOAT          = 0.0  

   --> Resultado de la Mesa de Distribucion  

   ,   @nResultadoMesa           FLOAT          = 0.0  

  

   ,   @cFecStarting             DATETIME       = ''   

   ,   @cFecFijacionStarting     DATETIME       = ''   

   ,   @nPtosTransfObs           FLOAT          = 0.0   

   ,   @nPtosTransfFwd           FLOAT          = 0.0   

   ,   @nPtosFwdCierre           FLOAT          = 0.0   

  

   ,   @nResultadoComex          FLOAT          = 0.0  

   ,   @NroOpeRelMxClp			 INT = 0  

   ,   @Calvtadol                FLOAT          = 1			--> Marca para los Fw Asiaticos (1 seg Cambio; 14, fw Obsr; 15 fw Asiatico)

   )  

AS  

BEGIN  

  

   SET NOCOUNT ON  



   BEGIN TRY

   	

	insert into dbo_tmp_log_turing_bac

    select @Modulo_BAC      

	   ,   @Tipo_Validacion

	   ,   @nnumoper  

	   ,   @ncodcart  

	   ,   @ncodigo   

	   ,   @ncodpos1  

	   ,   @ncodmon1  

	   ,   @ncodmon2  

	   ,   @ctipoper  

	   ,   @ctipmoda  

	   ,   @dfecha    

	   ,   @ntipcam   

	   ,   @nmdausd   

	   ,   @nmtomon1

	   ,   @nequusd1

	   ,   @nequmol1

	   ,   @nmtomon2

	   ,   @nequusd2

	   ,   @nequmol2

	   ,   @nparmon1

	   ,   @npremon1

	   ,   @nparmon2

	   ,   @npremon2

	   ,   @cestado  

	   ,   @cretiro  

	   ,   @ccontraparte  

	   ,   @cobserv

	   ,   @nspread

	   ,   @nprecal

	   ,   @nplazo

	   ,   @cfecvcto

	   ,   @clock  

	   ,   @coperador  

	   ,   @ntasausd  

	   ,   @ntasacon  

	   ,   @nfpagomn  

	   ,   @nfpagomx  

	   ,   @nMtoMon1ini

	   ,   @nMtoMon1fin

	   ,   @nMtoMon2ini

	   ,   @nMtoMon2fin

	   ,   @nentidad  

	   ,   @ncodcli

	   ,   @nMtoDif  

	   ,   @nBroker  

	   ,   @nMontoPFE  

	   ,   @nMontoCCE  

	   ,   @id_sistema  

	   ,   @Precio_Transferencia  

	   ,   @Tipo_Sintetico  

	   ,   @Precio_Spot  

	   ,   @Pais_Origen  

	   ,   @Moneda_Compensacion  

	   ,   @Riesgo_Sintetico  

	   ,   @Precio_Reversa_Sintetico  

	   ,   @npremio  

	   ,   @ctipopc  

	   ,   @precio_punta  

	   ,   @remunera_linea  

	   ,   @tasa_efectiva_moneda1  

	   ,   @tasa_efectiva_moneda2  

	   ,   @relacionada_spot  

	   ,   @tasaefectmon1  

	   ,   @tasaefectmon2  

	   ,   @ntipcamSpot  

	   ,   @ntipcamFwd  

	   ,   @dfechaefect  

	   ,   @Serie  

	   ,   @Seriado  

	   ,   @ntipcamPtosFwd  

	   ,   @CodAreaResponsable

	   ,   @CodCartNorm

	   ,   @CodSubCartNorm

	   ,   @CodLibro

	   ,   @estadoSina  

	   ,   @fechaSina  

	   ,   @nCostoUSDCLP  

	   ,   @nCostoMxUSD  

	   ,   @nCostoMxCLP  

	   ,   @iRefTc  

	   ,   @iRefParidad  

	   ,   @dRefTc  

	   ,   @dRefParidad  

	   ,   @nTipCamUSDCLP  

	   ,   @nSpotTc  

	   ,   @nSpotParidad  

	   ,   @nResultadoMesa  

	   ,   @cFecStarting   

	   ,   @cFecFijacionStarting   

	   ,   @nPtosTransfObs

	   ,   @nPtosTransfFwd

	   ,   @nPtosFwdCierre

	   ,   @nResultadoComex  

	   ,   @NroOpeRelMxClp  

	   ,   @Calvtadol

	   ,   Fecha_Sistema	= convert(datetime,convert(char(10), getdate(), 110))

       ,   Hora_Sistema		= convert(char(10), getdate(), 108)



   END TRY

   BEGIN CATCH

		
		DECLARE @err_msg_aux AS NVARCHAR(MAX);

		SET @err_msg_aux = ERROR_MESSAGE();		
		

		select 'NO', concat('Error en Turing(:)', ' - ',@err_msg_aux)

		return

 

   	/* 

   		SELECT

   			ERROR_NUMBER() AS ErrorNumber,

   			ERROR_SEVERITY() AS ErrorSeverity,

   			ERROR_STATE() AS ErrorState,

   			ERROR_PROCEDURE() AS ErrorProcedure,

   			ERROR_LINE() AS ErrorLine,

   			ERROR_MESSAGE() AS ErrorMessage

   	*/

   END CATCH



   -- Descarte en Duro de productos

   -- Cumplen OK mínimo: 1,2,3,

   If  @ncodpos1 in (  10, 11, 13 )

      begin

			   select 'NO', 'Turing no captura data completa, Producto debe ser ingresado por BAC'

			   return

 	  end



 









   -- Importante: no se puede leer cartera, solo variables



   -- Importante

   -- Activar o desactivar controles de integridad relacional

   declare @ValidarOperador varchar(1)

   declare @ValidarCarteraFinanciera varchar(1)

   declare @ValidarUsuarioCarteraNormativa varchar(1)



   select @ValidarOperador = 'S' 

   select @ValidarCarteraFinanciera = 'S'

   select @ValidarUsuarioCarteraNormativa = 'S'





   declare @MSG Varchar(400)

   declare @DetectaCierreMesa Varchar(1) -- 'S' o 'N'

   declare @ExisteCliente  Varchar(1)    -- 'S' o 'N'

   declare @ExisteProducto Varchar(1)    --	'S' o 'N'

   declare @Existe		   varchar(1)



   select @MSG = ''



   IF @Tipo_Validacion = 'RESTRICCIONES_AOP' 

   BEGIN



       -- Para Probar Activar este código

       -- select 'OK', ''



	   select @DetectaCierreMesa = 'S'

	   IF @Modulo_BAC = 'BFW' 

	   Begin      

		  Select @DetectaCierreMesa = case when acsw_ciemefwd = 1 then 'S' else 'N' end  from BacFwdSuda.dbo.MFAC

	       

	   End	   

	   if @DetectaCierreMesa = 'S' 

		  begin

			   select 'NO', 'Debe gestionar apertura de mesa para operar'

			   return

 	  end

     /*******************************************************************************************************	  

      Valida que el usuario tenga ACCESO_CARTERA_FINANCIERA

     *******************************************************************************************************/	  

     if @ValidarCarteraFinanciera = 'S' 

     Begin

	     exec BacParamSuda.dbo.SP_TURING_VALIDA_ACCESO_CARTERA_FINANCIERA @coperador,'BFW',@ncodpos1,@ncodcart,@Existe output -- Ok SS

           

      	 if @Existe = 'N' 

			   begin

				   select 'NO', 'Usuario no tiene acceso a estructura Financiera'

				   return

			   end

     end

     /*******************************************************************************************************	  

      Valida que el usuario tenga ACCESO NORMATIVO

     *******************************************************************************************************/	  

     if @ValidarUsuarioCarteraNormativa = 'S' 

     begin

	     exec BacParamSuda.dbo.SP_TURING_VALIDA_USUARIO_NORMATIVO @coperador,'BFW',@ncodpos1, @CodLibro, @CodCartNorm,@CodSubCartNorm,@Existe output -- Ok SS

           

      	 if @Existe = 'N' 

			   begin

				  select 'NO', 'Usuario no tiene acceso a estructura Normativa'

				   return

			   end	

      end

   END -- 'RESTRICCIONES_AOP' 

   ELSE

   BEGIN

       select @ExisteCliente = 'N'

       select @ExisteCliente = 'S' from BacParamSuda.dbo.Cliente where ClRut = @ncodigo and ClCodigo = @ncodcli     

       if @ExisteCliente = 'N' 

       begin

		   select 'NO', 'Cliente No Existe en BAC'

		   return

       end

  /*******************************************************************************************************	

   valida que exista producto 

  ********************************************************************************************************/

             

           exec SP_TURING_FWDPRODUCTO @ncodpos1 ,@Existe output -- Ok SS

           --select @ExisteProducto=@Existe    

 			 if @Existe = 'N' 

			   begin

				   select 'NO', 'Producto No Existe en BAC'

				   return

			   end



  /*******************************************************************************************************	

   valida que exista moneda 1

  ********************************************************************************************************/

         exec BacParamSuda.dbo.SP_TURING_MONEDA @ncodmon1 ,@Existe output  -- Ok SS

             

 			 if @Existe = 'N' 

			   begin

				   select 'NO', 'Codigo Moneda 1 No Existe en BAC'

				   return

			   end

         

 /*******************************************************************************************************	

   valida que exista moneda 2

  ********************************************************************************************************/

         exec BacParamSuda.dbo.SP_TURING_MONEDA @ncodmon2 ,@Existe output  -- Ok SS

                   

 			 if @Existe = 'N' 

			   begin

				   select 'NO', 'Codigo Moneda 2 No Existe en BAC'

				   return

			   end



/*******************************************************************************************************	

   valida que exista tipo operacion

********************************************************************************************************/

         exec BacParamSuda.dbo.SP_TURING_TIPOOPERACION @ctipoper ,@Existe output -- Ok SS

                   

 			 if @Existe = 'N' 

			   begin

				   select 'NO', 'Tipo Operacion No Existe en BAC'

				   return

			   end

/*******************************************************************************************************	

   valida que exista tipo Modalidad

 *******************************************************************************************************/

         exec BacParamSuda.dbo.SP_TURING_MODALIDAD @ctipmoda ,@Existe output  -- Ok SS

                   

 			 if @Existe = 'N' 

			   begin

				   select 'NO', 'Modalidad No Existe en BAC'

				   return

			   end



    

/*******************************************************************************************************	

   valida forma de pago MN

 *******************************************************************************************************/ 

 

  if @nFPagomn <> 0

  begin

 

	  exec BacParamSuda.dbo.SP_TURING_FORMADEPAGOMN @nFPagomn ,@Existe output  -- Ok SS

	                   

 				 if @Existe = 'N' 

				   begin

					   select 'NO', 'Forma de pago MN No Existe en BAC'

					   return

				   end



  end



	/*******************************************************************************************************	

	   valida forma de pago MX

	 *******************************************************************************************************/

	if @ctipmoda='E' 

	Begin

		exec BacParamSuda.dbo.SP_TURING_FORMADEPAGOMX @nFPagomx ,@Existe output -- Ok SS



 		if @Existe = 'N'

		begin

			set @nFPagomx = (select top 1 cafpagomx from bacfwdsuda.dbo.mfca with(nolock) where canumoper = @nnumoper)



			exec BacParamSuda.dbo.SP_TURING_FORMADEPAGOMX @nFPagomx ,@Existe output



			if @Existe = 'N'

			begin

				select	'NO', 'Forma de pago MX No Existe en BAC'

				return

			end

		end

	end else 

	begin

		select @nFPagomx=0

	end



/*******************************************************************************************************	

   valida cartera normativa

 *******************************************************************************************************/

  exec BacParamSuda.dbo.SP_TURING_VALIDA_CARTERA 1111,@CodCartNorm,@Existe output -- Ok SS

                 

 			 if @Existe = 'N' 

			   begin

				   select 'NO', 'Cartera Normativa No Existe en BAC'

				   return

			   end



/*******************************************************************************************************	

   valida Libro

 *******************************************************************************************************/

  exec BacParamSuda.dbo.SP_TURING_VALIDA_CARTERA 1552,@CodLibro,@Existe output  -- Ok SS

                   

 			 if @Existe = 'N' 

			   begin

				   select 'NO', 'Libro No Existe en BAC'

				   return

			   end



/*******************************************************************************************************	

   valida Subcartera

 *******************************************************************************************************/

  exec BacParamSuda.dbo.SP_TURING_VALIDA_CARTERA 1554,@CodSubCartNorm,@Existe output  -- Ok SS

                   

 			 if @Existe = 'N' 

			   begin

				   select 'NO', 'Subcartera No Existe en BAC'

				   return

			   end



/*******************************************************************************************************	

   valida Area Responsable

 *******************************************************************************************************/

  exec BacParamSuda.dbo.SP_TURING_VALIDA_CARTERA 1553,@CodAreaResponsable,@Existe output -- Ok SS

                   

 			 if @Existe = 'N' 

			   begin

				   select 'NO', 'Area Responsable No Existe en BAC'

				   return

			   end



/*******************************************************************************************************	

   valida Operador

 *******************************************************************************************************/

 if @ValidarOperador = 'S' Begin

             exec BacParamSuda.dbo.SP_TURING_VALIDA_OPERADOR @coperador,@Existe output -- Ok SS

                   

 			 if @Existe = 'N' 

			   begin

				   select 'NO', 'Operador No Existe en BAC'

				   return

			   end

 End

/*******************************************************************************************************	

   valida que usuario no sea perfil comex

 *******************************************************************************************************/

  --   Comentado hasta que se corrija Turing

        exec BacParamSuda.dbo.SP_TURING_USUARIOCOMEX @coperador ,@Existe output -- Okk SS

                   

 			 if @Existe = 'S' 

			   begin

				   select 'NO', 'Operador corresponde a perfil COMEX no puede Operar'

				   return

			   end



END

 -- 'RESTRICCIONES_TEC' @coperador

   -- Si se llega hasta acá está OK

  

   select 'OK', ''

   return



   SET NOCOUNT OFF  

END 


GO
