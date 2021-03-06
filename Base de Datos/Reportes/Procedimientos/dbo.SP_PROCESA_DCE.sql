USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROCESA_DCE]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PROCESA_DCE](    
			 @dce_line		int
			,@Type			varchar(10)
			,@Contract		varchar(50)
			,@DCE_contract  varchar(30)
			,@archivo		varchar(500)
			,@fec_archivo	datetime
			,@RETURN_VALUE	varchar(max) = NULL	OUTPUT
			 )    
AS
DECLARE @estado_ini char(1) = 'A'
DECLARE @estado_fin char(1) = 'I'
DECLARE @exist int = 0
BEGIN 	

	set nocount on 	
	if not exists(
			select 1 from dbo.TBL_PROCESO_DCE TPD with (nolock)
			where 
			--TPD.dce_linea = @dce_line AND 
			TPD.dce_contrato = @Contract
			AND TPD.dce_tipo = @Type
			) 
		begin
			set @exist = 0 --no existe
		end 
	else 
		begin 
			set @exist = 1	--existe
	end

	--print @exist
	begin transaction tr_dce_proceso
	if @exist = 0 begin
		 INSERT INTO dbo.TBL_PROCESO_DCE
		  (
		      --id - this column value is auto-generated
		      dce_linea,
		      dce_tipo,
		      dce_contrato,
		      dce_contrato_dce,
		      dce_archivo,
		      dce_fecarchivo,
		      dce_estado,
		      dce_fecins
		  )
		  VALUES
		  (
		      -- id - int
		      @dce_line,-- dce_linea - int
		      @Type,-- dce_tipo - varchar
		      @Contract,-- dce_contrato - numeric
		      @DCE_contract,-- dce_contrato_dce - varchar
		      @archivo,-- dce_archivo - varchar
		      @fec_archivo,-- dce_fecarchivo - datetime
		      @estado_ini,-- dce_estado - char
		      GETDATE()-- dce_fecins - datetime
		  )			  
		set @return_value = null	
	end
	else if @exist = 1 begin
		declare
		 @org_dce_contrato_dce varchar(30)
		,@org_archivo		   varchar(500)
		,@org_dce_contrato	   varchar(50)
		,@org_line			   int
		,@org_fecha_ins		   datetime
		,@org_type			   varchar(10)
		
		select 
		 @org_dce_contrato_dce=dce_contrato_dce
		,@org_archivo		  =dce_archivo
		,@org_dce_contrato	  =dce_contrato
		,@org_line			  =dce_linea
		,@org_type			  =dce_tipo
		from dbo.TBL_PROCESO_DCE  with (nolock)
		where 
		dce_contrato = @Contract
		and dce_tipo = @Type

		--print @org_dce_contrato_dce
		--print @org_archivo		  
		--print @org_dce_contrato	  
		--print @org_line			  
			
		if (@DCE_contract <> @org_dce_contrato_dce) begin
			update dbo.TBL_PROCESO_DCE
			set dce_estado = @estado_fin
			where 
			dce_contrato = @Contract
			and dce_tipo = @org_type
			
			INSERT INTO dbo.TBL_PROCESO_DCE
			(
			   --id - this column value is auto-generated
			   dce_linea,
			   dce_tipo,
			   dce_contrato,
			   dce_contrato_dce,
			   dce_archivo,
			   dce_fecarchivo,
			   dce_estado,
			   dce_fecins
			)
		   VALUES
			(
			   -- id - int
			   @dce_line, -- dce_linea - int
			   @Type, -- dce_tipo - varchar
			   @Contract, -- dce_contrato - numeric
			   @DCE_contract, -- dce_contrato_dce - varchar
			   @archivo, -- dce_archivo - varchar
			   @fec_archivo, -- dce_fecarchivo - datetime
			   @estado_ini, -- dce_estado - char
			   GETDATE()  -- dce_fecins - datetime
			)
		end
		set @return_value = null
	end
	commit transaction tr_dce_proceso
	if @@error <> 0 begin
		rollback transaction tr_dce_proceso
			select @return_value = 'ERROR INSERT | dce_linea :' + cast(@dce_line AS varchar(100)) +
									'| dce_tipo :' + @Type + 
									'| dce_contrato :' + cast(@Contract AS varchar(100)) + 
									'| dce_contrato_dce :' + @DCE_contract + 
									'| dce_archivo :' + @archivo + 
									'| dce_fecarchivo :' + CONVERT(varchar,@fec_archivo,120) 
			return @return_value
	end	
    set nocount off	
END
RETURN @RETURN_VALUE

GO
