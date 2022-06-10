<template xmlns:el-col="http://www.w3.org/1999/html">
  <el-container>
    <el-header>
      <header class="header">
        <el-row type="flex">
          <el-col :span="8">
            <el-input
              placeholder="请输入搜索的信息"
              v-model="queryInfo.information"
              clearable
              @clear="getUserList"
              style="margin-top:10px;left:10px"
            >
              <el-button
                slot="append"
                icon="el-icon-search"
                @click="getUserList"
              >搜索</el-button
              >
            </el-input>
          </el-col>
          <el-col>
            <el-button
              style="margin-left: 20px;margin-top:10px"
              icon="el-icon-document"
              v-if="this.$store.state.currentUser.user_role === 1"
              round
              @click="inputFileInfoVisible=true"
            >导入导出用户</el-button
            >
          </el-col>
        </el-row>
      </header>
    </el-header>
    <el-dialog
      class="FileInfoBox"
      title="导入导出用户"
      :visible.sync="inputFileInfoVisible"
      @close="clearFileInfo">
      <div class="filePathInfo" style="margin-left: 0%">
        <el-form
          ref="filePathInfo"
          :model="filePathInfo"
          label-width="auto"
          label-position="auto"
          :rules="rulesForFilePath">
          <el-form-item label="文件路径" prop="path">
            <el-input
              v-model="filePathInfo.path"
              placeholder="输入绝对路径"
            ></el-input>
          </el-form-item>
          <p style="margin-bottom: 40px">
          </p>
          <el-button
            type="primary"
            @click="exportfilePath(filePathInfo)"
            icon="el-icon-download"
            plain
            style="float: right"
          >导出</el-button
          >
          <el-button
            type="primary"
            @click="importfilePath(filePathInfo)"
            icon="el-icon-upload"
            plain
            style="float: left"
          >导入</el-button>
        </el-form>
      </div>
    </el-dialog>
    <el-main>
      <main class="main">
        <el-table ref="userTable" :data="userList" border stripe>
          <el-table-column
            type="index"
            :index="indexMethod"
            label="序号"
            width="60px"
          ></el-table-column>
          <el-table-column
            label="用户名"
            prop="user_name"
            width="200px"
          ></el-table-column>
          <el-table-column
            label="用户号码"
            prop="user_phone"
            width="450px"
          ></el-table-column>
          <el-table-column
            label="用户性别"
            prop="user_gender"
            width="150px"
          ></el-table-column>
          <el-table-column
            label="用户权限"
            prop="user_role"
            width="150px"
          ></el-table-column>
          <el-table-column label="操作">
            <template slot-scope="scope">
              <el-button
                type="primary is-plain"
                icon="el-icon-lock"
                size="mini"
                @click="showuserDialog(scope.row)"
              >修改信息</el-button
              >
              <el-button
                v-if="$store.state.currentUser.user_role === 1"
                type="danger"
                icon="el-icon-delete"
                size="mini"
                @click="deleteuserById(scope.row.user_id)"
                plain
              >删除用户</el-button
              >
              <el-button
                type="info"
                icon="el-icon-view"
                size="mini"
                @click="showUserAnalyseDialog(scope.row.user_id)"
                plain
              >
                用户花费明细
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </main>
    </el-main>

    <el-dialog
      title="用户花费明细"
      :visible.sync="userCostAnalyseDialogVisible"
      center
      :destroy-on-close="true"
      width="35%"
    >
      <div class="userCostPieChartBox" ref="userCostPieChart"></div>
    </el-dialog>

    <el-dialog
      title="修改密码"
      :visible.sync="showuser"
      width="25%"
      center
      :destroy-on-close="true"
    >
      <el-form ref="form" :model="userInfo" label-width="100px">
        <el-form-item label="用户名：" prop="userName">
          <el-input
            v-model="userInfo.user_name"
            placeholder="username"
            style="width: auto"
          ></el-input>
        </el-form-item>
        <el-form-item label="新密码：" prop="password">
          <el-input
            v-model="userInfo.user_password"
            :label-width="formLabelWidth"
            placeholder="请输入新密码"
            style="width: auto"
          ></el-input>
        </el-form-item>
        <el-form-item label="用户性别：" prop="gender">
          <el-select
            v-model="userInfo.user_gender"
            :label-width="formLabelWidth"
            placeholder="请设置性别"
            style="width: 207px"
          >
          <el-option label="男" value="男" ></el-option>
            <el-option label="女" value="女"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="新电话号码：" prop="phone">
          <el-input
            v-model="userInfo.user_phone"
            :label-width="formLabelWidth"
            placeholder="请输入新电话号码"
            style="width: auto"
          ></el-input>
        </el-form-item>
        <el-form-item
          label="用户权限："
          prop="phone"
          v-if="this.$store.state.currentUser.user_role === 1"
        >
          <el-select
            v-model="userInfo.user_role"
            :label-width="formLabelWidth"
            placeholder="权限设置"
            style="width: 207px"
          >
            <el-option label="1" value="1" ></el-option>
            <el-option label="0" value="0"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="showuser = false">取 消</el-button>
        <el-button type="primary" @click="update">修改</el-button>
      </div>
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
.userCostPieChartBox{
  width: 500px;
  height: 400px;
  margin-top: 15%;
}
</style>

<script>
export default {
  data () {
    return {
      showuser: false,
      isConsignor: true,
      userInfo: {
        user_name: '',
        user_id: 0,
        user_password: '',
        user_gender: '',
        user_phone: '',
        user_role: null
      },
      filePathInfo: {
        path: ''
      },
      ButtonInfo: '查看收件',
      userList: [],
      changeform: {
        username: '',
        password: ''
      },
      queryInfo: {
        information: '',
        page: 1,
        size: 5
      },
      total: 0,
      userCostAnalyseDialogVisible: false,
      formLabelWidth: '100px',
      rulesForFilePath: {
        path: [
          {
            required: true,
            message: '请输入路径',
            trigger: 'blur'
          },
          {
            max: 1000,
            message: 'URL limit 1000',
            trigger: 'blur'
          }
        ]
      },
      inputFileInfoVisible: false
    }
  },
  created () {
    this.getUserList()
  },
  methods: {
    async getUserList () {
      if (this.$store.state.currentUser.user_role === 1) {
        await this.$http
          .post('/user/findAllUser', this.queryInfo)
          .then(result => {
            this.userList = result.data.res
            this.total = result.data.total
          })
          .catch(err => {
            console.log(err)
          })
      }
      if (this.$store.state.currentUser.user_role === 0) {
        this.queryInfo.information = this.$store.state.currentUser.user_name
        await this.$http
          .post('/user/findAllUser', this.queryInfo)
          .then(result => {
            this.userList = result.data.res.filter(res => {
              return res.user_id === this.$store.state.currentUser.user_id
            })
            this.total = result.data.total
            this.queryInfo.information = ''
          })
          .catch(err => {
            console.log(err)
          })
      }
    },
    indexMethod (index) {
      return (this.queryInfo.page - 1) * this.queryInfo.size + 1 + index
    },
    handleSizeChange (newSize) {
      this.queryInfo.size = newSize
      this.getUserList()
    },
    handleCurrentChange (newPage) {
      this.queryInfo.page = newPage
      this.getUserList()
    },

    showuserDialog (user) {
      this.userInfo.user_id = user.user_id
      this.userInfo.user_name = user.user_name
      this.userInfo.user_gender = user.user_gender
      this.userInfo.user_password = user.user_password
      this.userInfo.user_phone = user.user_phone
      this.showuser = true
    },
    async update () {
      let userInfo = this.userInfo
      userInfo.user_id = this.$store.state.currentUser.user_id
      userInfo.user_role = this.$store.state.currentUser.user_role
      await this.$http
        .put('/user/updateUser', userInfo)
        .then(res => {
          console.log(res)
          this.$store.commit('setuser', {user: userInfo})
          this.$message.success('修改成功')
          this.getUserList()
          this.showuser = false
          console.log(this.$store.state.currentUser)
          console.log(userInfo)
        })
        .catch(err => {
          console.log(err)
        })
    },
    async importfilePath (filePathInfo) {
      if (this.$store.getters.getuser.user_role === 1) {
        const confirmRes = await this.$confirm(
          '确认导入用户？',
          '提示',
          {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }
        ).catch(err => err)
        if (confirmRes !== 'confirm') return this.$message.info('已取消')
        await this.$http
          .post('user/userImport', filePathInfo)
          .then(result => {
            if (!result.data) {
              this.$message.error('导入失败')
              this.getUserList()
            } else {
              this.$message.success('导入成功')
              console.log(result.data)
              this.getUserList()
            }
          })
      } else {
        this.$message.error('没有权限导入用户')
      }
    },
    async exportfilePath (filePathInfo) {
      if (this.$store.getters.getuser.user_role === 1) {
        const confirmRes = await this.$confirm(
          '确认导出用户？',
          '提示',
          {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }
        ).catch(err => err)
        if (confirmRes !== 'confirm') return this.$message.info('已取消')
        await this.$http
          .post('user/userExport', filePathInfo)
          .then(result => {
            if (!result.data) {
              this.$message.error('导出失败')
              this.getUserList()
            } else {
              this.$message.success('导出成功')
              console.log(result.data)
              this.getUserList()
            }
          })
      } else {
        this.$message.error('没有权限导出用户')
      }
    },
    async deleteuserById (id) {
      if (this.$store.state.currentUser.user_role === 1) {
        const confirmRes = await this.$confirm(
          '确认删除该用户？该操作不可逆',
          '提示',
          {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }
        ).catch(err => err)
        if (confirmRes !== 'confirm') return this.$message.info('已取消删除')
        await this.$http
          .delete('/user/deleteUser/' + id)
          .then(result => {
            if (!result.data) {
              this.$message.error('删除失败')
              this.getUserList()
            } else {
              this.$message.success('删除成功')
              console.log(result.data)
              this.getUserList()
            }
          })
          .catch(err => {
            console.log(err)
          })
      }
      if (this.$store.state.currentUser.user_role === 0) {
        this.$message.error('没有权限删除用户')
      }
    },
    clearFileInfo () {
      this.$refs.filePathInfo.resetFields()
    },
    showUserAnalyseDialog (id) {
      this.getUserCostAnalyse(id)
      this.userCostAnalyseDialogVisible = true
    },
    async getUserCostAnalyse (id) {
      await this.$http.get('user/getUserCostAnalyseInfo/' + id).then((result) => {
        console.log(result.data)
        let analyseInfo = result.data
        if (analyseInfo.length > 0) {
          var userCostPieChart = this.$echarts.init(this.$refs.userCostPieChart)
          var option = {
            title: {
              text: '用户花费明细',
              subtext: '百分比显示'
            },
            tooltip: {
              trigger: 'item',
              formatter: '{a}：{b} <br/> {c}元 ({d}%) <br/>'
            },
            legend: {
              bottom: 100,
              left: 'center',
              data: []
            },
            series: [
              {
                name: '货物',
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
          analyseInfo.forEach((item) => {
            let data = {value: item.cost, name: item.good_name}
            option.series[0].data.push(data)
            option.legend.data.push(item.good_name)
          })
          userCostPieChart.setOption(option)
        } else {
          return this.$message.info('暂无用户订单信息')
        }
      }).catch((err) => {
        console.log(err)
      })
    }

    // getUserOrder (id) {
    //   this.$router.push({
    //     path: '/order', query: {user_id: id}
    //   })
    // }
  }
}
</script>
