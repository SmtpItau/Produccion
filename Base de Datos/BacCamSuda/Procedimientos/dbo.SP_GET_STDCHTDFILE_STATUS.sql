USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_STDCHTDFILE_STATUS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GET_STDCHTDFILE_STATUS]( @Fecha AS VARCHAR(8) ,@Source AS VARCHAR(3), @SourceRefrence AS VARCHAR(20), @PureDealType AS SMALLINT, @DateOfDeal AS VARCHAR(8), @TimeOfDeal AS VARCHAR(8) ,@RevVer AS SMALLINT, @TransType AS SMALLINT) 
AS
BEGIN
      SET NOCOUNT  ON
    
     -- DECLARE @NAME_OF_FILE AS VARCHAR(100)
      DECLARE @STATUS AS VARCHAR(100)
      DECLARE @REVVER_STORED AS SMALLINT
      DECLARE @DATE_OF_DEAL_STORED AS DATETIME
      DECLARE @TIME_OF_DEAL_STORED AS VARCHAR(8)
      DECLARE @CORRELATIVO AS NUMERIC(10)	
           
      SELECT @STATUS = ''
      SELECT @REVVER_STORED = 0 

      SET @SourceRefrence = UPPER(@SourceRefrence)
	
      SELECT @STATUS = Status 
            ,@DATE_OF_DEAL_STORED = DateOfDeal 
            ,@TIME_OF_DEAL_STORED = TimeOfDeal
            ,@REVVER_STORED = Revision
            ,@CORRELATIVO = Correlativo  
      FROM tbl_stdChtd_status
      WHERE Fecha = @Fecha AND Source = @Source AND  SourceReference = @SourceRefrence AND PureDealType = @PureDealType
      
      IF @STATUS = ''
      BEGIN           
          
          SELECT  @CORRELATIVO = (MAX(Correlativo)) 
          FROM tbl_stdChtd_status
          WHERE Fecha = @Fecha

          SET @CORRELATIVO = ISNULL(@CORRELATIVO, 0) + 1 

          INSERT INTO tbl_stdChtd_status VALUES(@Fecha, @Source, @SourceRefrence, @CORRELATIVO ,@PureDealType, @DateOfDeal, @TimeOfDeal, @RevVer, GETDATE(), 'P' )
          SET @STATUS = 'P'  

      END          
      SELECT  'STATUS' = @STATUS  
             ,'CORRELATIVO' = @CORRELATIVO
      SET NOCOUNT  OFF
END
GO
