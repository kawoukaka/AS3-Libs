package com.kaka.utils
{
    /**
     * 处理 数组分页逻辑
     * */
    public class ArrayPage
    {
        private var _currentPage:int=1;
        private var _pageSize:int=1;
        private var _data:Array=[];
        /**
         * @param data:Array 数据
         * @param pagesize:int 分页尺寸
         * */
        public function ArrayPage(data:Array,pagesize:int=5)
        {
            _data=data;
            _pageSize=pagesize;
        }
        /**
         * 获取第 p页的数据
         * */
        public function getPageCord(p:int=1):Array
        {
			if(p<1)
                p = 1;
				
            if (p > totalPage)			
                p = totalPage;
			
            var start:int=(p-1)*pageSize;
            var end:int=p*pageSize;
            return _data.slice(start,end);
        }
        public function get data():Array
        {
            return _data;
        }
        public function set data(d:Array):void
        {
            _data=d;
        }
        /**
         * 每页设置 多少条 记录
         * */
        public function get pageSize():int
        {
            return _pageSize;
        }
        public function set pageSize(size:int):void
        {
            _pageSize=size;
        }
        /**
         * 按照当前 分页 一共分出多少页
         * */
        public function get totalPage():int   
        {
            return Math.ceil(_data.length / pageSize);
			
        }
        /**
         * 一共多少条记录
         * */
        public function get recordCount():int
        {
            return _data.length;
        }
       
        /**
         * 取data按照每页pagesize的尺寸 分页后 第page页的数据
         * @param data:Array 数据
         * @param pageSize:int 每页尺寸
         * @param page:int 取第几页数据
         * @return 第page页的数据
         * */
        public static function getThePageData(data:Array,pagesize:int,page:int):Array
        {
            return data.slice((page-1)*pagesize,page*pagesize);
        }
        /**
         * 获取data数组 按照 每页pagesize的个数,可以分多少页
         * @param data:Array 数据
         * @param pagesize:int 每页尺寸
         * @return 可以分出多少页
         * */
        public static function countTotalPage(data:Array,pagesize:int):int
        {
            return Math.ceil(data.length/pagesize);
        }
        /**
         * 取得index位置 所在的 页码
         * @param index:int 数据所在的位置
         * @param pagesize:int 分页时使用的 尺寸(每页几条显示数据)
         * */
        public static function getPageIndexByItemIndex(index:int,pagesize:int):int
        {
            return Math.ceil(index/pagesize);
        }
        /**
         * 取得 数据索引index所在位置 的那一页 数据
         * @param data:Array 数据源
         * @param pagesize:int 分页尺寸
         * @param itemindex:int  数据所在数据源的位置
         * */
		public static function getThePageDataByItemIndex(data:Array,pagesize:int,itemindex:int):Array
        {
            return getThePageData(data,pagesize,getPageIndexByItemIndex(itemindex,pagesize));
        }
        /**
         * 尝试将数据源填充到 可以分整页的状态
         * @param data:Array
         * */
        public static function addPageArray(data:Array,pagesize:int,item:Object=null):void
        {
            var total:int=countTotalPage(data,pagesize);
            var endarr:Array=getThePageData(data,pagesize,total);
            var dx:int=pagesize-endarr.length;
            var i:int;
            for(i=0;i<dx;i++)
            {
                data.push(item);
            }
        }
    }
}