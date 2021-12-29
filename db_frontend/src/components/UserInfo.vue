<template>
  <el-container>
    <el-header>
      <header class="header">
        <el-row type="flex">
          <el-col :span="6">
            <el-input
              placeholder="请输入搜索的信息"
              v-model="queryInfo.information"
              clearable
              @clear="getUserList"
            >
              <el-button
                slot="append"
                icon="el-icon-search"
                @click="getUserList"
                >搜索</el-button
              >
            </el-input>
          </el-col>
        </el-row>
      </header>
    </el-header>

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
                type="danger"
                icon="el-icon-delete"
                size="mini"
                @click="deleteuserById(scope.row.user_id)"
                plain
                >删除用户</el-button
              >
            </template>
          </el-table-column>
        </el-table>
      </main>
    </el-main>

    <el-dialog
      title="修改密码"
      :visible.sync="showuser"
      width="25%"
      center
      :destroy-on-close="true"
    >
      <el-form ref="form" :model="changeform" label-width="100px">
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
          <el-input
            v-model="userInfo.user_gender"
            :label-width="formLabelWidth"
            placeholder="请设置性别"
            style="width: auto"
          ></el-input>
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
          v-if="this.$store.getters.getuser.user_role === 1"
        >
          <el-input
            v-model="userInfo.user_role"
            :label-width="formLabelWidth"
            placeholder="权限设置"
            style="width: auto"
          ></el-input>
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
.el-input {
}
.el-pagination {
  text-align: center;
}
</style>

<script>
export default {
  data () {
    return {
      showuser: false,
      isConsignor: true,
      userInfo: {
        user_id: '',
        user_password: '',
        user_gender: '',
        user_pohne: '',
        user_role: ''
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
      formLabelWidth: '100px'
    }
  },
  created () {
    this.getUserList()
  },
  methods: {
    async getUserList () {
      if (this.$store.getters.getuser.user_role === 1) {
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
      if (this.$store.getters.getuser.user_role === 0) {
        this.queryInfo.information = this.$store.getters.getuser.user_name
        await this.$http
          .post('/user/findAllUser', this.queryInfo)
          .then(result => {
            this.userList = result.data.res.filter(res => {
              return res.user_id === this.$store.getters.getuser.user_id
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
      this.userInfo.user_pohne = user.user_pohne
      this.showuser = true
    },
    async update () {
      let userInfo = this.userInfo
      await this.$http
        .put('/user/updateUser', userInfo)
        .then(res => {
          console.log(res)

          this.$message.success('修改成功')
          this.getUserList()
          this.showuser = false
        })
        .catch(err => {
          console.log(err)
        })
    },
    async deleteuserById (id) {
      if (this.$store.getters.getuser.user_role === 1) {
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
      if (this.$store.getters.getuser.user_role === 0) {
        this.$message.error('没有权限删除用户')
      }
    }
    // getUserOrder (id) {
    //   this.$router.push({
    //     path: '/order', query: {user_id: id}
    //   })
    // }
  }
}
</script>
