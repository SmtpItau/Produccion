USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CUMPLE_RESTRICCIONES_OPERATIVAS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CUMPLE_RESTRICCIONES_OPERATIVAS]
   (   @Id_sistema            VarChar(3),  
       @Operacion             NUMERIC(10)       
   )  
AS      
BEGIN   
    -- POR HACER: Bokeo, Vigencia del Cliente
    -- SP_CUMPLE_RESTRICCIONES_OPERATIVAS 'PCS', 5381


    SET NOCOUNT ON  
    declare @CierreMesa numeric(2)
   
   declare @ValidarCarteraFinanciera varchar(1)
   declare @ValidarUsuarioCarteraNormativa varchar(1)
   declare @Existe         varchar(1)
   declare @coperador      Varchar(20)  
   declare @ncodpos1       numeric(02)
   declare @ncodcart       numeric(09)
   declare @Libro          varchar(10)
   declare @CodCartNorm    Varchar(6)
   declare @CodSubCartNorm Varchar(6)
   

   
   select @ValidarCarteraFinanciera = 'S'
   select @ValidarUsuarioCarteraNormativa = 'S'

   select  @coperador = Operador 
         , @ncodpos1  = Tipo_Swap 
         , @ncodcart  = cartera_inversion
         , @CodCartNorm    =  car_Cartera_Normativa 
         , @CodSubCartNorm = car_SubCartera_Normativa
         , @Libro     = car_Libro 
   from Cartera where numero_operacion = @Operacion
   -- select * from BacSwapSuda..Cartera where numero_operacion = 5381

    set @CierreMesa = 0
    select  @CierreMesa = cierreMesa from SwapGeneral
    if  @CierreMesa = 1 begin
       select 'NO', 'Debe gestionar apertura de mesa para operar'
       return
    end
    else
    Begin   

		 /*******************************************************************************************************	  
		  Valida que el usuario tenga ACCESO_CARTERA_FINANCIERA
		 *******************************************************************************************************/	  
		 if @ValidarCarteraFinanciera = 'S' 
		 Begin
			 exec BacParamSuda.dbo.SP_TURING_VALIDA_ACCESO_CARTERA_FINANCIERA @coperador,'PCS',@ncodpos1,  @ncodcart,@Existe output -- Ok SS
	           
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
			 exec BacParamSuda.dbo.SP_TURING_VALIDA_USUARIO_NORMATIVO @coperador,'PCS',@ncodpos1, @Libro, @CodCartNorm,@CodSubCartNorm,@Existe output -- Ok SS
	           
      		 if @Existe = 'N' 
				   begin
					   select 'NO', 'Usuario no tiene acceso a estructura Normativa'
					   return
				   end	
		  end    
    End
       select 'OK', ''
    
END
-- SP_CUMPLE_RESTRICCIONES_OPERATIVAS "PCS", 555use 
GO
