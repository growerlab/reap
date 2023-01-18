package repository

import (
	"context"
	"sort"
	"time"

	"github.com/asaskevich/govalidator"
	"github.com/growerlab/growerlab/src/backend/app/common/git"
	"github.com/growerlab/growerlab/src/common/errors"
	"github.com/growerlab/growerlab/src/common/path"
)

// TreeFiles 获取仓库的文件列表
// ref: 分支、commit、tag等
// dir: 目录
func (g *Take) TreeFiles(ref string, folder *string) ([]*git.FileEntity, error) {
	if g.repo == nil || govalidator.IsNull(*g.repo) {
		return nil, errors.MissingParameterError(errors.Repository, errors.Repo)
	}
	if folder == nil || govalidator.IsNull(*folder) {
		temp := "/"
		folder = &temp
	}

	var ctx, cancel = context.WithTimeout(context.TODO(), 30*time.Second)
	defer cancel()

	pathGroup := g.pathGroup()
	files, err := git.New(ctx, pathGroup).TreeFiles(ref, *folder)
	if err != nil {
		return nil, errors.Trace(err)
	}

	// sort
	sort.Sort(git.FileEntitySorter(files))
	return files, nil
}

func (g *Take) pathGroup() string {
	return path.GetPathGroup(g.namespace, *g.repo)
}
