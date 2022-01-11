<template>
  <el-container class="orderInfo">
    <el-header>
      <header class="header">
        <el-row type="flex">
          <el-col :span="8">
            <!-- 搜索区域 -->
            <el-input
              style="left:10px;top: 10px"
              placeholder="请输入搜索用户姓名或手机号"
              v-model="queryInfo.information"
              clearable
              @clear="getOrderList"
            >
              <el-button
                slot="append"
                icon="el-icon-search"
                @click="getOrderList"
              ></el-button>
            </el-input>
          </el-col>
          <el-col>
            <el-button
              style="margin-left: 20px; margin-top: 10px"
              icon="el-icon-plus"
              @click="addOrderDialogVisible = true"
              round
            >
              添加订单
            </el-button>
            <el-button
              style="margin-left: 10px; margin-top: 10px"
              icon="el-icon-upload"
              @click="importOrderDialogVisible = true"
              round
              v-if="this.$store.state.currentUser.user_role === 1"
            >
              导入订单
            </el-button>
            <el-button
              style="margin-left: 10px; margin-top: 10px"
              icon="el-icon-printer"
              @click="exportOrder"
              round
              v-if="this.$store.state.currentUser.user_role === 1"
            >
              导出订单
            </el-button>
            <el-button
              style="margin-left: 10px; margin-top: 10px"
              icon="el-icon-pie-chart"
              @click="showOrderAnalyseDialog"
              round
              v-if="this.$store.state.currentUser.user_role === 1"
            >
              订单分析
            </el-button>
             <el-button
              style="margin-left: 10px; margin-top: 10px"
              icon="el-icon-pie-chart"
              @click="showGoodAnalyseDialog"
              round
              v-if="this.$store.state.currentUser.user_role === 1"
            >
              货物分析
            </el-button>
          </el-col>
        </el-row>
      </header>
    </el-header>

    <el-main>
      <main class="main">
        <el-table ref="orderTable" :data="orderList" border stripe>
          <el-table-column
            type="index"
            :index="indexMethod"
            label="序号"
            width="60px"
          ></el-table-column>
          <el-table-column
            width="100px"
            label="寄件人"
            prop="consignor"
          ></el-table-column>
          <el-table-column
            width="150px"
            label="寄件人号码"
            prop="consignor_phone"
          ></el-table-column>
          <el-table-column
            width="100px"
            label="收件人"
            prop="consignee"
          ></el-table-column>
          <el-table-column
            width="150px"
            label="收件人号码"
            prop="consignee_phone"
          ></el-table-column>
          <el-table-column
            width="150px"
            label="货物"
            prop="good_name"
          ></el-table-column>
          <el-table-column
            width="80px"
            label="状态"
            prop="order_state"
          ></el-table-column>
          <el-table-column
            width="100px"
            label="发货点"
            prop="order_origin"
          ></el-table-column>
          <el-table-column
            width="100px"
            label="终点"
            prop="order_destination"
          ></el-table-column>
          <el-table-column label="操作">
            <template slot-scope="scope">
              <el-button
                type="primary is-plain"
                icon="el-icon-box"
                size="mini"
                @click="showorderTrackDialog(scope.row)"
                >物流信息</el-button
              >
              <el-button
                type="info"
                icon="el-icon-view"
                size="mini"
                @click="showEditOrderDialog(scope.row.order_id)"
                plain
                >订单信息</el-button
              >
              <el-button
                v-if="$store.state.currentUser.user_role === 1"
                type="danger"
                icon="el-icon-delete"
                size="mini"
                @click="deleteOrderById(scope.row.order_id)"
                plain
                >删除订单</el-button
              >
            </template>
          </el-table-column>
        </el-table>
      </main>
    </el-main>

    <el-dialog
      class="orderAnalyse"
      title="订单分析"
      center
      :visible.sync="orderAnalyseDialogVisible"
      width="35%"
      @close="orderAnalyseDialogClosed"
      :destroy-on-close="true"
    >
      <div class="orderPieChartBox" ref="orderPieChart"></div>
    </el-dialog>

    <el-dialog
      class="goodAnalyse"
      title="货物分析"
      center
      :visible.sync="goodAnalyseDialogVisible"
      @close="goodAnalyseDialogClosed"
    >
      <div class="goodAnalyseBox" style="display: flex">
        <div class="goodPieChartBox" ref="goodPieChart"></div>
        <div class="goodBarChartBox" ref="goodBarChart"></div>
      </div>
    </el-dialog>

    <el-dialog
      class="importOrder"
      title="导入订单"
      center
      :visible.sync="importOrderDialogVisible"
      width="26.5%"
      @close="handleImportOrderDialogClosed"
    >
      <div>
        <el-upload
          class="uploadOrder"
          ref = "uploadOrder"
          drag
          :before-upload="handleBeforeUpload"
          action="http://localhost:8085/excel/importOrder"
          :http-request="uploadFile"
        >
          <i class="el-icon-upload"></i>
          <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
          <div class="el-upload__tip" slot="tip">
            <span>只能上传xlsx</span>
            <el-button
              style="float:right"
              type="primary"
              icon="el-icon-check"
              size="mini"
              @click="importOrder"
              plain
              >开始导入
            </el-button>
          </div>
        </el-upload>
      </div>
    </el-dialog>

    <el-dialog
      class="orderTrack"
      title="物流信息"
      center
      :visible.sync="orderTrackDialogVisible"
      @close="orderTrackDialogClosed"
      v-if="this.$store.state.currentUser.user_role === 1"
      width="45%"
    >
      <div class="trackBox" style="display: flex">
        <div class="track">
          查看方式:
          <el-radio-group v-model="reverse">
            <el-radio :label="true">倒序</el-radio>
            <el-radio :label="false">正序</el-radio>
          </el-radio-group>
          <el-divider></el-divider>
          <el-timeline :reverse="reverse">
            <el-timeline-item
              v-for="(item, index) in orderTrack"
              :key="index"
              :icon="getIcon(index)"
              :color="getColor(index)"
              :timestamp="dateFormat(item.current_time)"
              placement="top"
            >
              <span>
                <p v-if="index == 0">
                  货物在[{{ item.current_location }}]等待发货
                </p>
                <p
                  v-else-if="
                    item.current_location == orderTrack.order_destination
                  "
                >
                  货物到达终点[{{ item.current_location }}]
                </p>
                <p v-else>货物到达[{{ item.current_location }}]</p>
                <el-button
                  type="danger"
                  icon="el-icon-delete"
                  circle
                  size="mini"
                  @click="deleteTrack(item)"
                ></el-button>
                <el-button
                  type="info"
                  icon="el-icon-edit"
                  circle
                  size="mini"
                  @click="deliverTrack(item)"
                ></el-button>
              </span>
            </el-timeline-item>
          </el-timeline>
        </div>
        <div class="addTrackInfo" style="margin-left: 20%">
          <el-card class="addTrackInfoCard" style="text-align: right">
            <span style="float: left">添加物流信息</span>
            <el-divider></el-divider>
            <el-form
              ref="trackInfo"
              :model="trackInfo"
              label-width="auto"
              label-position="auto"
              :rules="rulesForTrack"
            >
              <el-form-item label="日期:" prop="date">
                <el-date-picker
                  v-model="trackInfo.date"
                  align="right"
                  type="date"
                  placeholder="选择日期"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  :picker-options="pickerOptions"
                >
                </el-date-picker>
              </el-form-item>
              <el-form-item label="时间:" prop="time">
                <el-time-picker
                  v-model="trackInfo.time"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  placeholder="选择时间"
                >
                </el-time-picker>
              </el-form-item>
              <el-form-item label="地点" prop="current_location">
                <el-input
                  v-model="trackInfo.current_location"
                  placeholder="请输入地点"
                ></el-input>
              </el-form-item>
            </el-form>
            <el-button
              type="mini"
              @click="updateTrack"
              icon="el-icon-check"
              plain
              style="float: left"
              >更 新</el-button
            >
            <el-button type="mini" @click="addTrack" icon="el-icon-check" plain
              >提 交</el-button
            >
          </el-card>
        </div>
      </div>
    </el-dialog>

    <el-dialog
      class="orderTrack"
      title="物流信息"
      center
      :visible.sync="orderTrackDialogVisible"
      width="30%"
      @close="orderTrackDialogClosed"
      v-if="this.$store.state.currentUser.user_role === 0"
    >
      <div class="trackBox" style="display: flex">
        <div class="track">
          查看方式:
          <el-radio-group v-model="reverse">
            <el-radio :label="true">倒序</el-radio>
            <el-radio :label="false">正序</el-radio>
          </el-radio-group>
          <el-divider></el-divider>
          <el-timeline :reverse="reverse">
            <el-timeline-item
              v-for="(item, index) in orderTrack"
              :key="index"
              :icon="getIcon(index)"
              :color="getColor(index)"
              :timestamp="dateFormat(item.current_time)"
              placement="top"
            >
              <span>
                <p v-if="index == 0">货物从[{{ item.current_location }}]出发</p>
                <p
                  v-else-if="
                    item.current_location == orderTrack.order_destination
                  "
                >
                  货物到达终点[{{ item.current_location }}]
                </p>
                <p v-else>货物到达[{{ item.current_location }}]</p>
              </span>
            </el-timeline-item>
          </el-timeline>
        </div>
      </div>
    </el-dialog>

    <el-dialog
      class="OrderInfoBox"
      title="订单详情"
      :visible.sync="editOrderInfoDialogVisible"
      @close="clearGoodInfo"
    >
      <div class="editOrderInfoBox" style="display: flex">
        <el-card class="editGoodInfoCard">
          <span>货物信息</span>
          <el-divider></el-divider>
          <el-form
            ref="existingGoodInfo"
            :model="goodInfo"
            label-width="100px"
            label-position="auto"
            :rules="rulesForGood"
            :disabled="this.$store.state.currentUser.user_role === 0"
          >
            <el-form-item label="商品名:" prop="good_name">
              <el-input
                type="textarea"
                v-model="goodInfo.good_name"
                placeholder="请输入商品名"
              ></el-input>
            </el-form-item>
            <el-form-item label="重量(kg):" prop="good_weight">
              <el-input
                type="textarea"
                v-model="goodInfo.good_weight"
                placeholder="请输入重量"
                :change="check('weight')"
              ></el-input>
            </el-form-item>
            <el-form-item label="价格(¥):" prop="good_price">
              <el-input
                type="textarea"
                v-model="goodInfo.good_price"
                placeholder="请输入价格"
                :change="check('price')"
              ></el-input>
            </el-form-item>
          </el-form>
        </el-card>
        <el-card class="editOrderInfoCard">
          <span>订单信息</span>
          <el-divider></el-divider>
          <el-form
            ref="existingOrderInfo"
            :model="orderInfo"
            label-width="100px"
            label-position="auto"
            :rules="rulesForOrder"
            :disabled="this.$store.state.currentUser.user_role === 0"
          >
            <el-form-item label="发货地点:" prop="order_origin">
              <el-input
                type="textarea"
                v-model="orderInfo.order_origin"
                placeholder="请输入发货地点"
              ></el-input>
            </el-form-item>
            <el-form-item label="目的地:" prop="order_destination">
              <el-input
                type="textarea"
                v-model="orderInfo.order_destination"
                placeholder="请输入目的地"
              ></el-input>
            </el-form-item>
            <el-form-item label="状态:" prop="order_state">
              <el-select v-model="orderInfo.order_state" placeholder="订单状态">
                <el-option
                  v-for="item in orderStateList"
                  :key="item"
                  :label="item"
                  :value="item"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-form>
        </el-card>
      </div>
      <span slot="footer" class="goodInfoDialog-footer">
        <el-button
          type="info"
          @click="editOrderInfoDialogVisible = false"
          icon="el-icon-back"
          plain
          >取 消</el-button
        >
        <el-button
          v-if="this.$store.state.currentUser.user_role === 1"
          type="primary"
          @click="updateOrderInfo"
          icon="el-icon-check"
          plain
          >修 改</el-button
        >
      </span>
    </el-dialog>

    <el-dialog
      class="addOrderBox"
      title="添加订单"
      :visible.sync="addOrderDialogVisible"
      @close="addOrderDialogClosed"
    >
      <div class="orderInfoBox" style="display: flex">
        <el-card class="consignorCard">
          <span>发件人信息</span>
          <el-divider></el-divider>
          <el-form
            ref="consignorInfo"
            :model="consignor"
            label-width="auto"
            label-position="left"
            :rules="rulesForUser"
          >
            <el-form-item label="发件人:" prop="user_name">
              <el-input
                type="textarea"
                v-model="consignor.user_name"
                placeholder="请输入发件人姓名"
              ></el-input>
            </el-form-item>
            <el-form-item label="手机号:" prop="user_phone">
              <el-input
                type="textarea"
                v-model="consignor.user_phone"
                placeholder="请输入发件人手机号"
              ></el-input>
            </el-form-item>
            <el-form-item label="地址:" prop="user_address">
              <el-input
                type="textarea"
                v-model="consignor.user_address"
                placeholder="请输入发件人地址"
              ></el-input>
            </el-form-item>
          </el-form>
        </el-card>
        <el-card class="consigneeCard">
          <span>收件人信息</span>
          <el-divider></el-divider>
          <el-form
            ref="consigneeInfo"
            :model="consignee"
            label-width="auto"
            label-position="left"
            :rules="rulesForUser"
          >
            <el-form-item label="收件人:" prop="user_name">
              <el-input
                type="textarea"
                v-model="consignee.user_name"
                placeholder="请输入收件人姓名"
              ></el-input>
            </el-form-item>
            <el-form-item label="手机号:" prop="user_phone">
              <el-input
                type="textarea"
                v-model="consignee.user_phone"
                placeholder="请输入收件人手机号"
              ></el-input>
            </el-form-item>
            <el-form-item label="地址:" prop="user_address">
              <el-input
                type="textarea"
                v-model="consignee.user_address"
                placeholder="请输入收件人地址"
              ></el-input>
            </el-form-item>
          </el-form>
        </el-card>
        <el-card class="goodCard">
          <span>货物信息</span>
          <el-divider></el-divider>
          <el-form
            ref="goodInfo"
            :model="goodInfo"
            label-width="auto"
            label-position="left"
            :rules="rulesForGood"
          >
            <el-form-item label="货物名:" prop="good_name">
              <el-input
                type="textarea"
                v-model="goodInfo.good_name"
                placeholder="请输入货物名称"
              ></el-input>
            </el-form-item>
            <el-form-item label="货物重量:" prop="good_weight">
              <el-input
                type="textarea"
                v-model="goodInfo.good_weight"
                placeholder="请输入货物重量(kg)"
                @keyup.native="check('weight')"
              ></el-input>
            </el-form-item>
            <el-form-item label="货物价格:" prop="good_price">
              <el-input
                type="textarea"
                v-model="goodInfo.good_price"
                placeholder="请输入货物价格(¥)"
                @keyup.native="check('price')"
              ></el-input>
            </el-form-item>
          </el-form>
        </el-card>
      </div>
      <span slot="footer">
        <el-button
          type="info"
          @click="addOrderDialogVisible = false"
          icon="el-icon-back"
          plain
          >取 消</el-button
        >
        <el-button type="primary" @click="addOrder" icon="el-icon-check" plain
          >确 定</el-button
        >
      </span>
    </el-dialog>

    <el-footer>
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="queryInfo.page"
        :page-sizes="[1, 2, 5, 10]"
        :page-size="queryInfo.size"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
      ></el-pagination>
    </el-footer>
  </el-container>
</template>

<style scoped>
.el-footer {
  background: rgb(65, 61, 61);
}
.el-main {
  background: white;
}
.el-header {
  background: white;
}
.el-table {
  border-radius: 10px;
  /* margin-left: 30px; */
  margin-right: 30px;
}
.el-pagination {
  text-align: center;
}
.consignorCard {
  background: rgb(122, 170, 150, 0.7);
}
.consigneeCard {
  background: rgb(141, 169, 182, 0.7);
  margin-left: 15px;
}
.goodCard {
  background: rgb(182, 141, 141, 0.7);
  margin-left: 15px;
}
.editOrderInfoCard {
  background: rgba(140, 175, 184, 0.7);
  margin-left: 30px;
}
.editGoodInfoCard {
  background: rgba(182, 142, 190, 0.7);
}
.addTrackInfoCard {
  background: rgba(173, 190, 142, 0.7);
}
.orderPieChartBox {
  width: 500px;
  height: 400px;
  margin-top: 15%;
}
.goodAnalyseBox{
  width: 100%;
  height: 100%;
}
.goodPieChartBox{
  width: 500px;
  height: 400px;
  margin-top: 15%;
}
.goodBarChartBox{
  width: 500px;
  height: 400px;
}
</style>

<script>
export default {
  data () {
    return {
      file: {},
      isConsignor: true,
      orderList: [],
      queryInfo: {
        information: '',
        page: 1,
        size: 5
      },
      total: 0,
      orderTrackDialogVisible: false,
      editOrderInfoDialogVisible: false,
      importOrderDialogVisible: false,
      orderAnalyseDialogVisible: false,
      goodAnalyseDialogVisible: false,
      orderTrack: [],
      reverse: false,
      goodInfo: {
        good_price: 0.0,
        good_weight: 0.0,
        good_name: ''
      },
      orderInfo: {},
      consignor: {
        user_phone: '',
        user_name: '',
        user_address: ''
      },
      consignee: {
        user_phone: '',
        user_name: '',
        user_address: ''
      },
      trackInfo: {
        time: '',
        date: '',
        current_location: ''
      },
      oldTrackInfo: {
        time: '',
        date: '',
        current_location: ''
      },
      orderStateList: ['待发货', '已发货', '已送达'],
      addOrderDialogVisible: false,
      value6: '',
      startTime: '',
      pickerOptions: {
        disabledDate (time) {
          return time.getTime() > Date.now()
        }
      },
      rulesForUser: {
        user_name: [
          {
            required: true,
            message: '请输入用户姓名',
            trigger: 'blur'
          },
          {
            max: 30,
            message: '用户名的描述最长为30个字符',
            trigger: 'blur'
          }
        ],
        user_phone: [
          {
            required: true,
            message: '请输入手机号',
            trigger: 'blur'
          },
          {
            pattern: /^1[3456789]\d{9}$/,
            message: '手机格式错误',
            trigger: 'change'
          }
        ],
        user_address: [
          {
            required: true,
            message: '请输入地址',
            trigger: 'blur'
          },
          {
            max: 254,
            message: '地址过长',
            trigger: 'change'
          }
        ]
      },
      rulesForGood: {
        good_name: [
          {
            required: true,
            message: '请输入货物名',
            trigger: 'blur'
          },
          {
            max: 30,
            message: '货物名的描述最长为30个字符',
            trigger: 'blur'
          }
        ],
        good_weight: [
          {
            required: true,
            message: '请输入货物重量',
            trigger: 'blur'
          }
        ],
        good_price: [
          {
            required: true,
            message: '请输入货物价格',
            trigger: 'blur'
          }
        ]
      },
      rulesForOrder: {
        order_destination: [
          {
            required: true,
            message: '请输入货物终点',
            trigger: 'blur'
          }
        ],
        order_origin: [
          {
            required: true,
            message: '请输入货物起点',
            trigger: 'blur'
          }
        ]
      },
      rulesForTrack: {
        time: [
          {
            required: true,
            message: '请输入日期',
            trigger: 'change'
          }
        ],
        date: [
          {
            required: true,
            message: '请输入时间',
            trigger: 'change'
          }
        ],
        current_location: [
          {
            required: true,
            message: '请输入地点',
            trigger: 'change'
          },
          {
            max: 254,
            message: '地点名过长',
            trigger: 'blur'
          }
        ]
      }
    }
  },
  created () {
    this.getOrderList()
  },
  methods: {
    async getOrderList () {
      var size = this.queryInfo.size
      var page = this.queryInfo.page
      if (this.$store.state.currentUser.user_role === 0) {
        this.queryInfo.size = 0
      }
      await this.$http
        .post('/order/findAllOrder', this.queryInfo)
        .then((result) => {
          this.queryInfo.size = size
          if (this.$store.state.currentUser.user_role === 0) {
            this.orderList = result.data.res.filter(res => {
              return ((res.consignor === this.$store.state.currentUser.user_name && res.consignor_phone === this.$store.state.currentUser.user_phone) ||
                      (res.consignee === this.$store.state.currentUser.user_name && res.consignee_phone === this.$store.state.currentUser.user_phone))
            })
            this.total = this.orderList.length
            this.orderList = this.orderList.slice((page - 1) * size, (page - 1) * size + size)
          } else {
            this.orderList = result.data.res
            this.total = result.data.total
          }
          // this.orderList = result.data.res
          // this.total = result.data.total
          console.log(result)
        })
        .catch((err) => {
          console.log(err)
        })
    },
    indexMethod (index) {
      return (this.queryInfo.page - 1) * this.queryInfo.size + 1 + index
    },
    handleSizeChange (newSize) {
      this.queryInfo.page = 1
      this.queryInfo.size = newSize
      this.getOrderList()
    },
    handleCurrentChange (newPage) {
      this.queryInfo.page = newPage
      this.getOrderList()
    },
    async getOrderTrack (order) {
      await this.$http
        .get('/order/findOrderTrack/' + order.order_id)
        .then((result) => {
          this.orderTrack = result.data.res
          this.orderTrack.order_destination = order.order_destination
          this.orderTrack.order_id = order.order_id
        })
        .catch((err) => {
          console.log(err)
        })
    },
    async getgoodInfo (id) {
      await this.$http
        .get('/good/findGoodById/' + id)
        .then((result) => {
          this.goodInfo = result.data.res
          console.log(result)
        })
        .catch((err) => {
          console.log(err)
        })
    },
    async getOrderInfo (id) {
      await this.$http
        .get('/order/findOrderById/' + id)
        .then((result) => {
          this.orderInfo = result.data.res
          console.log(result)
        })
        .catch((err) => {
          console.log(err)
        })
    },
    addTrack () {
      this.$refs.trackInfo.validate(async (valid) => {
        if (valid) {
          this.trackInfo.order_id = this.orderTrack.order_id
          var date = '' + this.trackInfo.date
          var time = '' + this.trackInfo.time
          this.trackInfo.current_time = Date.parse(
            date.slice(0, 10) + ' ' + time.slice(11, 19)
          )
          await this.$http
            .post('/track/addTrack', this.trackInfo)
            .then((result) => {
              if (result.data === 'ok') {
                this.$message.success('添加成功')
                this.getOrderTrack(this.orderTrack)
                this.$forceUpdate()
              } else if (result.data === 'existing') {
                this.$message.info('存在相同数据')
              } else {
                this.$message.error('添加异常')
              }
            })
            .catch((err) => {
              console.log(err)
            })
        } else {
          this.$message.error('信息不完善或有误')
        }
      })
    },
    async deleteTrack (track) {
      track.current_time = Date.parse(this.dateFormat(track.current_time))
      console.log(track)
      await this.$http
        .delete('/track/deleteSpecificTrack', { data: track })
        .then((result) => {
          if (result.data === 'ok') {
            this.$message.success('删除成功')
            this.getOrderTrack(this.orderTrack)
            this.$forceUpdate()
          } else {
            this.$message.error('删除异常')
          }
        })
        .catch((err) => {
          console.log(err)
        })
    },
    deliverTrack (track) {
      var timeInfo = this.dateFormat(track.current_time)
      this.oldTrackInfo.date = this.oldTrackInfo.time = timeInfo
      this.trackInfo.date = this.trackInfo.time = timeInfo
      this.oldTrackInfo.current_location = this.trackInfo.current_location =
        track.current_location
    },
    async updateTrack () {
      this.$refs.trackInfo.validate(async (valid) => {
        if (valid) {
          this.oldTrackInfo.order_id = this.trackInfo.order_id =
            this.orderTrack.order_id
          var date = '' + this.trackInfo.date
          var time = '' + this.trackInfo.time
          this.trackInfo.current_time = Date.parse(
            date.slice(0, 10) + ' ' + time.slice(11, 19)
          )
          date = '' + this.oldTrackInfo.date
          time = '' + this.oldTrackInfo.time
          this.oldTrackInfo.current_time = Date.parse(
            date.slice(0, 10) + ' ' + time.slice(11, 19)
          )
          var tracksInfo = {
            oldTrackInfo: this.oldTrackInfo,
            newTrackInfo: this.trackInfo
          }
          this.$http
            .post('/track/updateTrack', tracksInfo)
            .then((result) => {
              if (result.data === 'ok') {
                this.$message.success('更新成功')
                this.getOrderTrack(this.orderTrack)
                this.oldTrackInfo.time = this.trackInfo.time
                this.oldTrackInfo.date = this.trackInfo.date
                this.oldTrackInfo.current_location =
                  this.trackInfo.current_location
                this.$forceUpdate()
              } else {
                this.$message.error('更新异常')
              }
            })
            .catch((err) => {
              console.log(err)
            })
        } else {
          this.$message.error('信息不完善或有误')
        }
      })
    },
    async deleteOrderById (id) {
      const confirmRes = await this.$confirm(
        '确认删除该订单？该操作不可逆',
        '提示',
        {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }
      ).catch((err) => err)
      if (confirmRes !== 'confirm') return this.$message.info('已取消删除')
      await this.$http
        .delete('/order/deleteOrderById/' + id)
        .then((result) => {
          if (result.data === 'ok') {
            this.$message.success('删除成功')
            this.getOrderList()
          } else {
            this.$message.error('删除异常')
            this.getOrderList()
          }
        })
        .catch((err) => {
          console.log(err)
        })
    },
    addOrder () {
      this.$refs.consignorInfo.validate((valid) => {
        if (valid) {
          this.$refs.consigneeInfo.validate((valid) => {
            if (valid) {
              this.$refs.goodInfo.validate(async (valid) => {
                if (valid) {
                  var orderInfo = {
                    consignor: this.consignor,
                    consignee: this.consignee,
                    goodInfo: this.goodInfo,
                    orderInfo: {
                      order_origin: this.consignor.user_address,
                      order_destination: this.consignee.user_address
                    }
                  }
                  console.log(orderInfo)
                  await this.$http
                    .post('/order/addOrder', orderInfo)
                    .then((result) => {
                      if (result.data === 'ok') {
                        this.$message.success('添加成功')
                        this.getOrderList()
                        this.addOrderDialogVisible = false
                      } else {
                        this.$message.error('添加异常')
                      }
                    })
                    .catch((err) => {
                      console.log(err)
                    })
                } else {
                  return this.$message.error('货物信息未完善或错误')
                }
              })
            } else {
              return this.$message.error('收件人信息未完善或错误')
            }
          })
        } else {
          return this.$message.error('发件人信息未完善或错误')
        }
      })
    },
    updateOrderInfo () {
      this.$refs.existingGoodInfo.validate((valid) => {
        if (valid) {
          this.$refs.existingOrderInfo.validate(async (valid) => {
            if (valid) {
              await this.$http
                .post('good/updateGoodInfo', this.goodInfo)
                .then(async (result) => {
                  if (result.data === 'ok') {
                    await this.$http
                      .post('order/updateOrderInfo', this.orderInfo)
                      .then((result) => {
                        if (result.data === 'ok') {
                          this.$message.success('修改成功')
                          this.getOrderList()
                          this.editOrderInfoDialogVisible = false
                        } else {
                          return this.$message.error('修改异常')
                        }
                      })
                      .catch((err) => {
                        console.log(err)
                      })
                  } else {
                    return this.$message.error('修改异常')
                  }
                })
                .catch((err) => {
                  console.log(err)
                })
            } else {
              return this.$message.error('订单信息不完善或有误')
            }
          })
        } else {
          return this.$message.error('货物信息不完善或有误')
        }
      })
    },
    showorderTrackDialog (order) {
      this.getOrderTrack(order)
      this.orderTrackDialogVisible = true
    },
    showEditOrderDialog (id) {
      this.getgoodInfo(id)
      this.getOrderInfo(id)
      this.editOrderInfoDialogVisible = true
    },
    getIcon (index) {
      var icon = ''
      if (index === 0) {
        icon = 'el-icon-s-flag'
      } else {
        icon = 'el-icon-check'
      }
      return icon
    },
    getColor (index) {
      var color = ''
      if (index === 0) {
        color = '#5C00FF'
      } else {
        color = '#67C23A'
      }
      return color
    },
    dateFormat (cellValue) {
      if (cellValue == null || cellValue === '') return ''
      let date = new Date(parseInt(cellValue)) // 时间戳为10位需*1000，如果为13位的话不需乘1000。
      let Y = date.getFullYear() + '-'
      let M =
        date.getMonth() + 1 < 10
          ? '0' + (date.getMonth() + 1) + '-'
          : date.getMonth() + 1 + '-'
      let D =
        date.getDate() < 10 ? '0' + date.getDate() + ' ' : date.getDate() + ' '
      let h =
        date.getHours() < 10
          ? '0' + date.getHours() + ':'
          : date.getHours() + ':'
      let m =
        date.getMinutes() < 10
          ? '0' + date.getMinutes() + ':'
          : date.getMinutes() + ':'
      let s =
        date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds()
      return Y + M + D + h + m + s
    },
    check (type) {
      var data = ''
      if (type === 'price') {
        data = data + this.goodInfo.good_price
      } else {
        data = data + this.goodInfo.good_weight
      }
      data = data
        .replace(/[^\d.]/g, '') // 清除“数字”和“.”以外的字符
        .replace(/\.{2,}/g, '.') // 只保留第一个. 清除多余的
        .replace('.', '$#$')
        .replace(/\./g, '')
        .replace('$#$', '.')
        .replace(/^(-)*(\d+)\.(\d\d).*$/, '$1$2.$3') // 只能输入两个小数
      if (data.indexOf('.') < 0 && data !== '') {
        // 以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额
        data = parseFloat(data)
      }
      if (type === 'price') {
        this.goodInfo.good_price = data
      } else {
        this.goodInfo.good_weight = data
      }
    },
    addOrderDialogClosed () {
      this.$refs.consignorInfo.resetFields()
      this.$refs.consigneeInfo.resetFields()
      this.$refs.goodInfo.resetFields()
    },
    clearGoodInfo () {
      this.$refs.existingGoodInfo.resetFields()
      this.$refs.existingOrderInfo.resetFields()
    },
    orderTrackDialogClosed () {
      this.trackInfo = {
        time: '',
        date: '',
        current_location: ''
      }
    },
    handleBeforeUpload (file) {
      let extension = file.name.substring(file.name.lastIndexOf('.') + 1)
      if (JSON.stringify(this.file) !== '{}') {
        this.$message.error('只能选择一个文件')
        return false
      }
      if (extension !== 'xlsx') {
        this.$message.error('只能上传xlsx的文件')
        return false
      }
    },
    handleImportOrderDialogClosed () {
      console.log(JSON.stringify(this.file))
      this.file = {}
      this.$refs.uploadOrder.clearFiles()
    },
    async importOrder () {
      let fd = new FormData()
      fd.append('file', this.file)
      await this.$http
        .post('excel/importOrder', fd, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        })
        .then((result) => {
          if (result.data === 'ok') {
            this.$message.success('导入成功')
            this.getOrderList()
            this.importOrderDialogVisible = false
          } else {
            this.$message.error('导入异常')
          }
        })
        .catch((err) => {
          console.log(err)
        })
    },
    async exportOrder () {
      await this.$http
        .get('excel/exportOrder')
        .then((result) => {
          window.location.href = result.request.responseURL
        })
        .catch((err) => {
          console.log(err)
        })
    },
    uploadFile (item) {
      this.file = item.file
    },
    showOrderAnalyseDialog () {
      this.getOrderAnalysePieChartInfo()
      this.orderAnalyseDialogVisible = true
    },
    orderAnalyseDialogClosed () {
      this.$echarts.dispose(this.$refs.orderPieChart)
    },
    goodAnalyseDialogClosed () {
      this.$echarts.dispose(this.$refs.goodPieChart)
    },
    showGoodAnalyseDialog () {
      this.getGoodAnalysePieChartInfo()
      this.goodAnalyseDialogVisible = true
    },
    async getOrderAnalysePieChartInfo () {
      await this.$http.get('/order/findOrders/').then((result) => {
        let analyseInfo = result.data
        if (analyseInfo.length > 0) {
          var orderPieChart = this.$echarts.init(this.$refs.orderPieChart)
          var option = {
            title: {
              text: '订单分析图表',
              subtext: '百分比显示'
            },
            tooltip: {
              trigger: 'item',
              formatter: '{a}：{b} <br/> {c}个 ({d}%) <br/>'
            },
            legend: {
              bottom: 100,
              left: 'center',
              data: ['待发货', '已发货', '已送达']
            },
            series: [
              {
                name: '订单状态',
                type: 'pie',
                radius: '50%',
                center: ['50%', '35%'],
                data: [
                  { value: 0, name: '待发货' },
                  { value: 0, name: '已发货' },
                  { value: 0, name: '已送达' }
                ],
                avoidLabelOverlap: true,
                itemStyle: {
                  emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                  }
                }
              }
            ]
          }
          analyseInfo.forEach((item) => {
            switch (item.order_state) {
              case '待发货':
                option.series[0].data[0].value++
                break
              case '已发货':
                option.series[0].data[1].value++
                break
              case '已送达':
                option.series[0].data[2].value++
                break
              default:
                option.series[0].data[0].value++
                break
            }
          })
          orderPieChart.setOption(option)
        } else {
          return this.$message.info('暂无订单信息')
        }
      })
    },
    async getGoodAnalysePieChartInfo () {
      await this.$http.get('/good/getGoodAnalyseInfo').then((result) => {
        let analyseInfo = result.data
        if (analyseInfo.length > 0) {
          var goodPieChart = this.$echarts.init(this.$refs.goodPieChart)
          var goodBarChart = this.$echarts.init(this.$refs.goodBarChart)
          var pieOption = {
            title: {
              text: '货物销售额图表',
              subtext: '百分比显示'
            },
            tooltip: {
              trigger: 'item',
              formatter: '{a}：{b} <br/> {c}元 ({d}%) <br/>'
            },
            legend: {
              bottom: 70,
              left: 'center',
              data: []
            },
            series: [
              {
                name: '货物名称',
                type: 'pie',
                radius: '50%',
                center: ['50%', '35%'],
                data: [],
                avoidLabelOverlap: true,
                itemStyle: {
                  emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                  }
                }
              }
            ]
          }
          var barOption = {
            title: {
              text: '货物销售量分布图表',
              x: 'center'
            },
            grid: {
              x2: 10,
              height: '70%'
            },
            tooltip: {
              trigger: 'item',
              formatter: '{a}：{b} <br/> {c}件'
            },
            xAxis: {
              data: [],
              axisLabel: {
                internal: 0,
                rotate: 30
              }
            },
            yAxis: {
              show: false,
              min: 0 // y轴的最小值
            },
            legend: {
              orient: 'vertical',
              right: 'right',
              data: []
            },
            series: [
              {
                name: '选择类型',
                type: 'bar',
                data: [],
                avoidLabelOverlap: true,
                itemStyle: {
                  normal: {
                    label: {
                      show: true,
                      position: 'top',
                      formatter: '{c}件'
                    },
                    color: function (params) {
                      // 让不同选项显示不同的颜色
                      var colorList = [
                        '#C1232B',
                        '#B5C334',
                        '#FCCE10',
                        '#E87C25'
                      ]
                      let index = params.dataIndex % 4
                      return colorList[index]
                    }
                  }
                }
              }
            ]
          }
          analyseInfo.forEach((item) => {
            let pieData = {value: item.sale, name: item.good_name}
            let barData = {value: item.number, name: item.good_name}
            pieOption.series[0].data.push(pieData)
            pieOption.legend.data.push(item.good_name)
            barOption.xAxis.data.push(item.good_name)
            barOption.legend.data.push(item.good_name)
            barOption.series[0].data.push(barData)
          })
          goodPieChart.setOption(pieOption)
          goodBarChart.setOption(barOption)
        } else {
          return this.$message.info('暂无货物销售信息')
        }
      })
    }
  }
}
</script>
