
#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' productMoldConfigUploadServer()
productMoldConfigUploadServer <- function(input,output,session,dms_token) {


  #获取参数
  text_file_productMoldConfig_upload = tsui::var_file("text_file_productMoldConfig_upload")



  shiny::observeEvent(input$btn_productMoldConfig_upload,{

    filename =text_file_productMoldConfig_upload()



    if(filename==''  || is.null(filename)){

      tsui::pop_notice("请先上传文件")


    }else{

      data <- readxl::read_excel(filename,col_types = c("numeric", "text", "text",
                                                        "text", "text", "text", "text", "text",
                                                        "numeric", "text"))


      data = as.data.frame(data)
      data = tsdo::na_standard(data)

      tsda::db_writeTable2(token = dms_token,table_name = 'rds_src_t_productMoldConfig_input',r_object = data,append = TRUE)


      mdlKRProductMoldConfigPkg::productMoldConfig_upload(dms_token = dms_token)
      tsui::pop_notice("上传成功")
    }

  })

}

#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' productMoldConfigViewServer()
productMoldConfigViewServer <- function(input,output,session,dms_token) {


  #获取参数
  text_file_productMoldConfig_FBillNo = tsui::var_text("text_file_productMoldConfig_FBillNo")



  shiny::observeEvent(input$btn_productMoldConfig_view,{

    FBillNo =text_file_productMoldConfig_FBillNo()

    data = mdlKRProductMoldConfigPkg::productMoldConfig_view(dms_token = dms_token,FBillNo=FBillNo)

    tsui::run_dataTable2(id = 'productMoldConfig_resultView',data = data)


    tsui::run_download_xlsx(id = 'dl_productMoldConfig_download',data =data ,filename = '产品模具配置表.xlsx')


  })

}


#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' productMoldConfigServer()
productMoldConfigServer <- function(input,output,session,dms_token) {

  productMoldConfigUploadServer(input = input,output = output,session = session,dms_token = dms_token)
  productMoldConfigViewServer(input = input,output = output,session = session,dms_token = dms_token)


}
